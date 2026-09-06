import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/app_colors.dart';
import '../../app/providers.dart';
import '../../core/calc/echipamente.dart';
import '../../core/calc/materiale.dart';
import '../../core/calc/pv_estimare.dart';
import '../../core/calc/releveu.dart';
import '../../core/db/releveu_repository.dart';
import '../../core/data/localitati_romania.dart';
import '../../core/db/repositories.dart';
import '../../core/models/enums.dart';
import '../../core/models/solutie.dart';
import '../../core/services/log_service.dart';
import '../../core/utils/format.dart';
import '../../widgets/calc_widgets.dart';
import '../../widgets/common_widgets.dart';
import 'solutie_widgets.dart';

enum _Acoperis { tigla, tabla, terasa }

/// Estimarea sistemului fotovoltaic pentru o fișă: intrări → calcul →
/// rezultat → salvare ca revizie a soluției tehnice (§6.2 F).
class EstimareScreen extends ConsumerStatefulWidget {
  final String lucrareId;

  /// Revizia de la care pornim (recalcul), dacă există.
  final IntrariSolutie? deLa;
  const EstimareScreen({super.key, required this.lucrareId, this.deLa});

  @override
  ConsumerState<EstimareScreen> createState() => _EstimareScreenState();
}

class _EstimareScreenState extends ConsumerState<EstimareScreen> {
  final _form = GlobalKey<FormState>();
  bool _initializat = false;
  bool _salveaza = false;

  final _consumLunar = TextEditingController();
  final _consumAnual = TextEditingController();
  ProfilConsum _profil = ProfilConsum.casnic;
  int _faze = 1;
  final _putereAprobata = TextEditingController();
  final _judet = TextEditingController();
  final _azimut = TextEditingController(text: '0');
  final _inclinare = TextEditingController(text: '30');
  final _suprafata = TextEditingController();
  double _acoperire = 100;
  ModStocare _stocare = ModStocare.fara;
  final _autonomie = TextEditingController(text: '8');
  ModulPV _modul = CatalogImplicit.module.first;
  final _lungimeDc = TextEditingController(text: '25');
  final _lungimeAc = TextEditingController(text: '15');
  final _lungimeContor = TextEditingController(text: '5');
  bool _prizaNoua = false;
  _Acoperis _acoperis = _Acoperis.tigla;
  final _distanta = TextEditingController(text: '0');
  final _pretCumparare = TextEditingController(text: '1,30');
  final _pretInjectare = TextEditingController(text: '0,65');
  final _tMin = TextEditingController(text: '-25');
  double _umbrire = 1.0;
  bool _releveuPreluat = false;
  final _observatii = TextEditingController();

  SolutieSnapshot? _rezultat;
  String? _sursaReleveu;

  /// Preia din releveu ce s-a măsurat pe teren: suprafața utilă, orientarea
  /// planului principal, umbrirea și lungimile traseelor.
  void _preiaDinReleveu(ReleveuComplet r, String judet) {
    final plane = r.plane.where(
      (p) => !StarePlan.dinCod(p.plan.stare).blocheazaMontajul,
    );
    if (plane.isEmpty) return;
    var suprafata = 0.0;
    var umbrirePonderata = 0.0;
    PlanCuObstacole? principal;
    var maxKwp = -1.0;
    for (final p in plane) {
      final cap = CalculReleveu.capacitate(
        tip: TipPlanMontaj.dinCod(p.plan.tip),
        lungimeM: p.plan.lungimeM,
        latimeM: p.plan.latimeM,
        inclinareGrade: p.plan.inclinareGrade,
        modul: _modul,
        latitudine: CalculReleveu.latitudineJudet(judet),
        stare: StarePlan.dinCod(p.plan.stare),
        obstacole: [
          for (final o in p.obstacole)
            (inaltimeM: o.inaltimeM, distantaM: o.distantaM),
        ],
      );
      // suprafața pe care chiar încap module, nu cea brută
      final utila = cap.nrModule * _modul.suprafataM2 * 1.15;
      suprafata += utila;
      umbrirePonderata += cap.factorUmbrire * utila;
      if (cap.kWp > maxKwp) {
        maxKwp = cap.kWp;
        principal = p;
      }
    }
    if (suprafata <= 0 || principal == null) return;
    _suprafata.text = formatNumar(suprafata, zecimale: 0);
    _azimut.text = formatNumar(principal.plan.azimutGrade, zecimale: 0);
    _inclinare.text = formatNumar(principal.plan.inclinareGrade, zecimale: 0);
    final umbrire = umbrirePonderata / suprafata;
    _umbrire = umbrire;
    for (final t in r.trasee) {
      final ctrl = switch (SegmentTraseu.dinCod(t.segment)) {
        SegmentTraseu.dc => _lungimeDc,
        SegmentTraseu.ac => _lungimeAc,
        SegmentTraseu.contor => _lungimeContor,
        _ => null,
      };
      if (ctrl != null && t.lungimeM > 0) {
        ctrl.text = formatNumar(t.lungimeM, zecimale: 0);
      }
    }
    final invelitoare = TipInvelitoare.dinCod(principal.plan.invelitoare);
    _acoperis = TipPlanMontaj.dinCod(principal.plan.tip).esteOrizontal
        ? _Acoperis.terasa
        : (invelitoare.cereSuportTabla ? _Acoperis.tabla : _Acoperis.tigla);
    _sursaReleveu =
        '${r.plane.length} plane măsurate · ${principal.plan.denumire} ca plan principal'
        '${umbrire < 0.99 ? ' · umbrire ${((1 - umbrire) * 100).toStringAsFixed(0)} %' : ''}';
  }

  void _initializeaza(FisaLucrare fisa) {
    if (_initializat) return;
    _initializat = true;
    final lc = fisa.locConsum;
    final d = widget.deLa;
    if (d != null) {
      _consumAnual.text = formatNumar(d.consumAnualKwh, zecimale: 0);
      _consumLunar.text = formatNumar(d.consumAnualKwh / 12, zecimale: 0);
      _profil = d.profilEnum;
      _faze = d.faze;
      _putereAprobata.text = d.putereAprobataKva == null
          ? ''
          : formatNumar(d.putereAprobataKva);
      _judet.text = d.judet;
      _azimut.text = formatNumar(d.azimutGrade, zecimale: 0);
      _inclinare.text = formatNumar(d.inclinareGrade, zecimale: 0);
      _suprafata.text = d.suprafataUtilaM2 == 0
          ? ''
          : formatNumar(d.suprafataUtilaM2, zecimale: 0);
      _acoperire = d.acoperire * 100;
      _stocare = d.stocareEnum;
      _autonomie.text = formatNumar(d.autonomieBackupOre, zecimale: 0);
      _modul = d.modul;
      _lungimeDc.text = formatNumar(d.lungimeDcM, zecimale: 0);
      _lungimeAc.text = formatNumar(d.lungimeAcM, zecimale: 0);
      _lungimeContor.text = formatNumar(d.lungimeTeg2ContorM, zecimale: 0);
      _prizaNoua = d.prizaPamantNoua;
      _acoperis = d.terasa
          ? _Acoperis.terasa
          : (d.acoperisTabla ? _Acoperis.tabla : _Acoperis.tigla);
      _distanta.text = formatNumar(d.distantaKm, zecimale: 0);
      _pretCumparare.text = formatNumar(d.pretCumparareKwh);
      _pretInjectare.text = formatNumar(d.pretInjectareKwh);
      _tMin.text = formatNumar(d.tMinC, zecimale: 0);
      return;
    }
    if (lc != null) {
      _faze = TipBransament.dinCod(lc.bransament) == TipBransament.trifazat
          ? 3
          : 1;
      _putereAprobata.text = lc.putereAprobataKva == null
          ? ''
          : formatNumar(lc.putereAprobataKva);
      _judet.text = lc.judet;
      _prizaNoua = !lc.prizaPamantProprie;
      _profil =
          DestinatieCladire.dinCod(lc.destinatieCladire) ==
              DestinatieCladire.rezidential
          ? ProfilConsum.casnic
          : ProfilConsum.diurn;
    }
  }

  @override
  void dispose() {
    for (final c in [
      _consumLunar,
      _consumAnual,
      _putereAprobata,
      _judet,
      _azimut,
      _inclinare,
      _suprafata,
      _autonomie,
      _lungimeDc,
      _lungimeAc,
      _lungimeContor,
      _distanta,
      _pretCumparare,
      _pretInjectare,
      _tMin,
      _observatii,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  IntrariSolutie _intrari() => IntrariSolutie(
    consumAnualKwh: parseNumar(_consumAnual.text) ?? 0,
    profil: _profil.cod,
    faze: _faze,
    putereAprobataKva: parseNumar(_putereAprobata.text),
    judet: _judet.text.trim(),
    azimutGrade: parseNumar(_azimut.text) ?? 0,
    inclinareGrade: parseNumar(_inclinare.text) ?? 30,
    suprafataUtilaM2: parseNumar(_suprafata.text) ?? 0,
    acoperire: _acoperire / 100,
    stocare: _stocare.cod,
    autonomieBackupOre: parseNumar(_autonomie.text) ?? 8,
    pAcMaxDoritaKw: 0,
    modulModel: _modul.model,
    tMinC: parseNumar(_tMin.text) ?? -25,
    pretCumparareKwh: parseNumar(_pretCumparare.text) ?? 1.3,
    pretInjectareKwh: parseNumar(_pretInjectare.text) ?? 0.65,
    lungimeDcM: parseNumar(_lungimeDc.text) ?? 25,
    lungimeAcM: parseNumar(_lungimeAc.text) ?? 15,
    lungimeTeg2ContorM: parseNumar(_lungimeContor.text) ?? 5,
    prizaPamantNoua: _prizaNoua,
    acoperisTabla: _acoperis == _Acoperis.tabla,
    terasa: _acoperis == _Acoperis.terasa,
    distantaKm: parseNumar(_distanta.text) ?? 0,
  );

  void _calculeaza() {
    if (!_form.currentState!.validate()) {
      log.warn('estimare', 'Formular invalid la calcul');
      return;
    }
    final i = _intrari();
    final e = EstimatorPV.estimeaza(
      IntrariEstimare(
        consumAnualKwh: i.consumAnualKwh,
        profil: i.profilEnum,
        faze: i.faze,
        putereAprobataKva: i.putereAprobataKva,
        judet: i.judet,
        azimutGrade: i.azimutGrade,
        inclinareGrade: i.inclinareGrade,
        suprafataUtilaM2: i.suprafataUtilaM2,
        factorUmbrire: _umbrire,
        acoperire: i.acoperire,
        stocare: i.stocareEnum,
        autonomieBackupOre: i.autonomieBackupOre,
        pAcMaxDoritaKw: i.pAcMaxDoritaKw,
        modul: i.modul,
        tMinC: i.tMinC,
        pretCumparareKwh: i.pretCumparareKwh,
        pretInjectareKwh: i.pretInjectareKwh,
      ),
    );
    final n = NecesarMateriale.din(
      e,
      lungimeDcM: i.lungimeDcM,
      lungimeAcM: i.lungimeAcM,
      lungimeTeg2ContorM: i.lungimeTeg2ContorM,
      prizaPamantNoua: i.prizaPamantNoua,
      acoperisTabla: i.acoperisTabla,
      terasa: i.terasa,
      distantaKm: i.distantaKm,
    );
    setState(() {
      _rezultat = SolutieSnapshot(
        intrari: i,
        rezultat: RezultatSolutie.din(e, n),
      );
    });
    FocusScope.of(context).unfocus();
  }

  Future<void> _salveazaRevizie() async {
    final r = _rezultat;
    if (r == null) return;
    setState(() => _salveaza = true);
    try {
      final id = await ref
          .read(solutiiRepositoryProvider)
          .adaugaRevizie(
            lucrareId: widget.lucrareId,
            snapshot: r,
            observatii: _observatii.text.trim(),
          );
      if (!mounted) return;
      context.pop();
      context.push('/registru/${widget.lucrareId}/solutie/$id');
    } on Object catch (e) {
      if (!mounted) return;
      setState(() => _salveaza = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Salvarea a eșuat: $e')));
    }
  }

  String? _obligatoriuNumar(String? v) =>
      (v == null || v.trim().isEmpty || parseNumar(v) == null)
      ? 'Număr obligatoriu'
      : null;
  String? _numarOptional(String? v) =>
      (v == null || v.trim().isEmpty || parseNumar(v) != null)
      ? null
      : 'Număr invalid';

  @override
  Widget build(BuildContext context) {
    final fisa = ref.watch(fisaProvider(widget.lucrareId)).value;
    if (fisa == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Estimare sistem')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    _initializeaza(fisa);
    if (!_releveuPreluat && widget.deLa == null) {
      final r = ref.watch(releveuProvider(widget.lucrareId)).value;
      if (r != null && r.plane.isNotEmpty) {
        _releveuPreluat = true;
        _preiaDinReleveu(r, fisa.locConsum?.judet ?? '');
      }
    }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text('Estimare · ${fisa.lucrare.nrInregistrare}')),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
          children: [
            if (_sursaReleveu != null)
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: context.successSurface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: context.successBorder),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.straighten,
                      size: 18,
                      color: context.successText,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Date preluate din releveu: $_sursaReleveu',
                        style: TextStyle(
                          fontSize: 12,
                          color: context.successText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const CalcSectionTitle(
              'Consum',
              icon: Icons.electric_meter_outlined,
            ),
            Row(
              children: [
                Expanded(
                  child: CalcNumberField(
                    controller: _consumLunar,
                    label: 'Consum lunar mediu',
                    suffix: 'kWh',
                    onChanged: (v) {
                      final n = parseNumar(v);
                      if (n != null) {
                        _consumAnual.text = formatNumar(n * 12, zecimale: 0);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CalcNumberField(
                    controller: _consumAnual,
                    label: 'Consum anual',
                    suffix: 'kWh',
                    validator: _obligatoriuNumar,
                    onChanged: (v) {
                      final n = parseNumar(v);
                      if (n != null) {
                        _consumLunar.text = formatNumar(n / 12, zecimale: 0);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            CalcSegmented<ProfilConsum>(
              label: 'Profil de consum',
              selected: _profil,
              options: {for (final p in ProfilConsum.values) p: p.eticheta},
              onChanged: (v) => setState(() => _profil = v),
            ),
            const SizedBox(height: 8),
            Text(
              'Acoperirea consumului: ${_acoperire.toStringAsFixed(0)} %',
              style: TextStyle(fontSize: 12, color: context.subtitleColor),
            ),
            Slider(
              value: _acoperire,
              min: 30,
              max: 150,
              divisions: 24,
              label: '${_acoperire.toStringAsFixed(0)} %',
              onChanged: (v) => setState(() => _acoperire = v),
            ),
            const CalcSectionTitle(
              'Racord',
              icon: Icons.electrical_services_outlined,
            ),
            CalcSegmented<int>(
              label: 'Branșament',
              selected: _faze,
              options: const {1: 'Monofazat', 3: 'Trifazat'},
              onChanged: (v) => setState(() => _faze = v),
            ),
            const SizedBox(height: 12),
            CalcNumberField(
              controller: _putereAprobata,
              label: 'Putere aprobată (ATR)',
              suffix: 'kVA',
              helper:
                  'Gol = fără limită; invertorul se limitează la valoarea din ATR',
              validator: _numarOptional,
            ),
            const CalcSectionTitle('Amplasament', icon: Icons.roofing_outlined),
            Autocomplete<String>(
              initialValue: TextEditingValue(text: _judet.text),
              optionsBuilder: (v) => judeteRomania.where(
                (j) => j.toLowerCase().contains(v.text.trim().toLowerCase()),
              ),
              onSelected: (j) => _judet.text = j,
              fieldViewBuilder: (context, ctrl, focus, _) => TextFormField(
                controller: ctrl,
                focusNode: focus,
                onChanged: (v) => _judet.text = v,
                decoration: const InputDecoration(
                  labelText: 'Județ',
                  helperText: 'Determină producția specifică (kWh/kWp/an)',
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: CalcNumberField(
                    controller: _azimut,
                    label: 'Azimut',
                    suffix: '°',
                    helper: '0 = sud, −90 = est, 90 = vest',
                    validator: _obligatoriuNumar,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CalcNumberField(
                    controller: _inclinare,
                    label: 'Înclinare',
                    suffix: '°',
                    helper: '0 = orizontal',
                    validator: _obligatoriuNumar,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            CalcNumberField(
              controller: _suprafata,
              label: 'Suprafață utilă de montaj (opțional)',
              suffix: 'm²',
              helper: '~5 m²/kWp pe acoperiș înclinat',
              validator: _numarOptional,
            ),
            const SizedBox(height: 12),
            CalcSegmented<_Acoperis>(
              label: 'Tip acoperiș',
              selected: _acoperis,
              options: const {
                _Acoperis.tigla: 'Țiglă',
                _Acoperis.tabla: 'Tablă',
                _Acoperis.terasa: 'Terasă / sol',
              },
              onChanged: (v) => setState(() => _acoperis = v),
            ),
            const CalcSectionTitle(
              'Echipamente',
              icon: Icons.solar_power_outlined,
            ),
            DropdownButtonFormField<ModulPV>(
              initialValue: _modul,
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Modul fotovoltaic'),
              items: [
                for (final m in CatalogImplicit.module)
                  DropdownMenuItem(
                    value: m,
                    child: Text(m.denumire, overflow: TextOverflow.ellipsis),
                  ),
              ],
              onChanged: (m) => setState(() => _modul = m ?? _modul),
            ),
            const SizedBox(height: 12),
            EnumDropdown<ModStocare>(
              label: 'Stocare',
              value: _stocare,
              values: ModStocare.values,
              eticheta: (v) => v.eticheta,
              onChanged: (v) => setState(() => _stocare = v),
            ),
            if (_stocare == ModStocare.backup) ...[
              const SizedBox(height: 12),
              CalcNumberField(
                controller: _autonomie,
                label: 'Autonomie dorită la pană',
                suffix: 'ore',
                validator: _numarOptional,
              ),
            ],
            const SizedBox(height: 12),
            CalcNumberField(
              controller: _tMin,
              label: 'Temperatura minimă de proiectare',
              suffix: '°C',
              helper: '−25 °C implicit; −30 °C în depresiuni și la munte',
              validator: _obligatoriuNumar,
            ),
            const CalcSectionTitle(
              'Trasee și montaj',
              icon: Icons.cable_outlined,
            ),
            Row(
              children: [
                Expanded(
                  child: CalcNumberField(
                    controller: _lungimeDc,
                    label: 'Traseu DC',
                    suffix: 'm',
                    validator: _obligatoriuNumar,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CalcNumberField(
                    controller: _lungimeAc,
                    label: 'Traseu AC',
                    suffix: 'm',
                    validator: _obligatoriuNumar,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CalcNumberField(
                    controller: _lungimeContor,
                    label: 'TEG → contor',
                    suffix: 'm',
                    validator: _obligatoriuNumar,
                  ),
                ),
              ],
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Priză de pământ nouă'),
              subtitle: const Text(
                '3 electrozi + platbandă + piesă de separație',
              ),
              value: _prizaNoua,
              onChanged: (v) => setState(() => _prizaNoua = v),
            ),
            CalcNumberField(
              controller: _distanta,
              label: 'Distanță până la șantier',
              suffix: 'km',
              validator: _numarOptional,
            ),
            const CalcSectionTitle(
              'Prețuri energie',
              icon: Icons.savings_outlined,
            ),
            Row(
              children: [
                Expanded(
                  child: CalcNumberField(
                    controller: _pretCumparare,
                    label: 'Preț cumpărare',
                    suffix: 'RON/kWh',
                    validator: _obligatoriuNumar,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CalcNumberField(
                    controller: _pretInjectare,
                    label: 'Valoare injectare',
                    suffix: 'RON/kWh',
                    validator: _obligatoriuNumar,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CalcButton(
              label: 'Calculează sistemul',
              icon: Icons.calculate,
              culoare: AccentFill.blue,
              onPressed: _calculeaza,
            ),
            if (_rezultat != null) ...[
              const SizedBox(height: 20),
              RezultatSolutieView(s: _rezultat!),
              const SizedBox(height: 12),
              TextFormField(
                controller: _observatii,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Observații la revizie (opțional)',
                ),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: _salveaza ? null : _salveazaRevizie,
                icon: const Icon(Icons.save_outlined),
                label: const Text('Salvează ca revizie a soluției tehnice'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Revizia se salvează cu toate valorile de mai sus; documentele PDF se emit din revizia salvată.',
                  style: TextStyle(fontSize: 12, color: context.subtitleColor),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/app_colors.dart';
import '../../app/providers.dart';
import '../../core/calc/echipamente.dart';
import '../../core/calc/releveu.dart';
import '../../core/db/database.dart';
import '../../core/models/enums.dart';
import '../../core/services/senzori_service.dart';
import '../../core/utils/format.dart';
import '../../widgets/calc_widgets.dart';
import '../../widgets/common_widgets.dart';

/// Un plan de montaj: dimensiuni, orientare (din busolă și inclinometru),
/// învelitoare, stare și obstacolele care umbresc.
class PlanFormScreen extends ConsumerStatefulWidget {
  final String lucrareId;
  final String releveuId;
  final String? planId;
  final String judet;

  const PlanFormScreen({
    super.key,
    required this.lucrareId,
    required this.releveuId,
    required this.judet,
    this.planId,
  });

  @override
  ConsumerState<PlanFormScreen> createState() => _PlanFormScreenState();
}

class _PlanFormScreenState extends ConsumerState<PlanFormScreen> {
  final _form = GlobalKey<FormState>();
  bool _incarcat = false;
  bool _salveaza = false;
  String? _idPlan;

  final _denumire = TextEditingController();
  TipPlanMontaj _tip = TipPlanMontaj.acoperisInclinat;
  TipInvelitoare _invelitoare = TipInvelitoare.tiglaCeramica;
  final _inclinare = TextEditingController(text: '30');
  final _azimut = TextEditingController(text: '0');
  final _lungime = TextEditingController();
  final _latime = TextEditingController();
  final _capriorSectiune = TextEditingController();
  final _capriorInterax = TextEditingController();
  StarePlan _stare = StarePlan.buna;
  final _observatii = TextEditingController();

  List<ObstacoleData> _obstacole = const [];

  StreamSubscription<CitireSenzori>? _senzori;
  CitireSenzori? _citire;

  bool get _editare => widget.planId != null;

  @override
  void initState() {
    super.initState();
    _idPlan = widget.planId;
    if (_editare) {
      _incarca();
    } else {
      _incarcat = true;
      _denumire.text = 'Versant 1';
    }
  }

  Future<void> _incarca() async {
    final complet = await ref
        .read(releveuRepositoryProvider)
        .watchPentruLucrare(widget.lucrareId)
        .first;
    final p = complet?.plane
        .where((x) => x.plan.id == widget.planId)
        .firstOrNull;
    if (!mounted) return;
    if (p == null) {
      setState(() => _incarcat = true);
      return;
    }
    setState(() {
      final d = p.plan;
      _denumire.text = d.denumire;
      _tip = TipPlanMontaj.dinCod(d.tip);
      _invelitoare = TipInvelitoare.dinCod(d.invelitoare);
      _inclinare.text = formatNumar(d.inclinareGrade, zecimale: 0);
      _azimut.text = formatNumar(d.azimutGrade, zecimale: 0);
      _lungime.text = formatNumar(d.lungimeM);
      _latime.text = formatNumar(d.latimeM);
      _capriorSectiune.text = d.capriorSectiune;
      _capriorInterax.text = d.capriorInteraxCm == null
          ? ''
          : formatNumar(d.capriorInteraxCm, zecimale: 0);
      _stare = StarePlan.dinCod(d.stare);
      _observatii.text = d.observatii;
      _obstacole = p.obstacole;
      _incarcat = true;
    });
  }

  @override
  void dispose() {
    _senzori?.cancel();
    ref.read(senzoriProvider).opreste();
    for (final c in [
      _denumire,
      _inclinare,
      _azimut,
      _lungime,
      _latime,
      _capriorSectiune,
      _capriorInterax,
      _observatii,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  void _comutaSenzori() {
    final s = ref.read(senzoriProvider);
    if (_senzori != null) {
      _senzori?.cancel();
      _senzori = null;
      s.opreste();
      setState(() => _citire = null);
      return;
    }
    s.porneste();
    _senzori = s.citiri.listen((c) {
      if (mounted) setState(() => _citire = c);
    });
    setState(() {});
  }

  void _preiaDinSenzori() {
    final c = _citire;
    if (c == null) return;
    setState(() {
      _inclinare.text = c.inclinareGrade.toStringAsFixed(0);
      if (c.busolaDisponibila) {
        _azimut.text = c.azimutFataDeSud.toStringAsFixed(0);
      }
    });
  }

  PlaneMontajCompanion _date() => PlaneMontajCompanion(
    releveuId: Value(widget.releveuId),
    denumire: Value(_denumire.text.trim()),
    tip: Value(_tip.cod),
    invelitoare: Value(_invelitoare.cod),
    inclinareGrade: Value(parseNumar(_inclinare.text) ?? 30),
    azimutGrade: Value(parseNumar(_azimut.text) ?? 0),
    lungimeM: Value(parseNumar(_lungime.text) ?? 0),
    latimeM: Value(parseNumar(_latime.text) ?? 0),
    capriorSectiune: Value(_capriorSectiune.text.trim()),
    capriorInteraxCm: Value(parseNumar(_capriorInterax.text)),
    stare: Value(_stare.cod),
    factorUmbrire: Value(_capacitate?.factorUmbrire ?? 1),
    observatii: Value(_observatii.text.trim()),
  );

  CapacitatePlan? get _capacitate {
    final l = parseNumar(_lungime.text) ?? 0;
    final lat = parseNumar(_latime.text) ?? 0;
    if (l <= 0 || lat <= 0) return null;
    return CalculReleveu.capacitate(
      tip: _tip,
      lungimeM: l,
      latimeM: lat,
      inclinareGrade: parseNumar(_inclinare.text) ?? 30,
      modul: CatalogImplicit.module.first,
      latitudine: CalculReleveu.latitudineJudet(widget.judet),
      stare: _stare,
      obstacole: [
        for (final o in _obstacole)
          (inaltimeM: o.inaltimeM, distantaM: o.distantaM),
      ],
    );
  }

  Future<void> _salveazaPlan() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _salveaza = true);
    final repo = ref.read(releveuRepositoryProvider);
    try {
      if (_editare) {
        await repo.actualizeazaPlan(widget.planId!, _date());
      } else {
        _idPlan = await repo.adaugaPlan(_date());
      }
      if (mounted) context.pop();
    } on Object catch (e) {
      if (!mounted) return;
      setState(() => _salveaza = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Salvarea a eșuat: $e')));
    }
  }

  Future<void> _adaugaObstacol() async {
    if (_idPlan == null) {
      // obstacolele au nevoie de un plan salvat
      if (!_form.currentState!.validate()) return;
      _idPlan = await ref.read(releveuRepositoryProvider).adaugaPlan(_date());
    }
    if (!mounted) return;
    final rezultat = await showModalBottomSheet<ObstacoleCompanion>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _ObstacolSheet(planId: _idPlan!),
    );
    if (rezultat == null) return;
    await ref.read(releveuRepositoryProvider).adaugaObstacol(rezultat);
    await _reincarcaObstacole();
  }

  Future<void> _reincarcaObstacole() async {
    final complet = await ref
        .read(releveuRepositoryProvider)
        .watchPentruLucrare(widget.lucrareId)
        .first;
    final p = complet?.plane.where((x) => x.plan.id == _idPlan).firstOrNull;
    if (mounted) setState(() => _obstacole = p?.obstacole ?? const []);
  }

  String? _numarObligatoriu(String? v) =>
      (v == null || v.trim().isEmpty || parseNumar(v) == null)
      ? 'Număr obligatoriu'
      : null;

  @override
  Widget build(BuildContext context) {
    final cap = _capacitate;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(_editare ? 'Editare plan' : 'Plan de montaj nou'),
      ),
      body: !_incarcat
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _form,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
                children: [
                  TextFormField(
                    controller: _denumire,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: 'Denumire',
                      hintText: 'ex. Versant sud, Terasă bloc',
                    ),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Obligatoriu' : null,
                  ),
                  const SizedBox(height: 12),
                  EnumDropdown<TipPlanMontaj>(
                    label: 'Tip plan',
                    value: _tip,
                    values: TipPlanMontaj.values,
                    eticheta: (v) => v.eticheta,
                    onChanged: (v) => setState(() {
                      _tip = v;
                      if (v.esteOrizontal &&
                          (parseNumar(_inclinare.text) ?? 30) > 20) {
                        _inclinare.text = '15';
                      }
                    }),
                  ),
                  const SizedBox(height: 12),
                  EnumDropdown<TipInvelitoare>(
                    label: 'Învelitoare',
                    value: _invelitoare,
                    values: TipInvelitoare.values,
                    eticheta: (v) => v.eticheta,
                    onChanged: (v) => setState(() => _invelitoare = v),
                  ),
                  const SizedBox(height: 20),
                  const CalcSectionTitle(
                    'Orientare',
                    icon: Icons.explore_outlined,
                  ),
                  _CardSenzori(
                    citire: _citire,
                    activ: _senzori != null,
                    onComuta: _comutaSenzori,
                    onPreia: _preiaDinSenzori,
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
                          validator: _numarObligatoriu,
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CalcNumberField(
                          controller: _inclinare,
                          label: 'Înclinare',
                          suffix: '°',
                          helper: _tip.esteOrizontal
                              ? 'unghiul structurii'
                              : 'panta acoperișului',
                          validator: _numarObligatoriu,
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const CalcSectionTitle(
                    'Dimensiuni utile',
                    icon: Icons.straighten,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CalcNumberField(
                          controller: _lungime,
                          label: 'Lungime (pe orizontală)',
                          suffix: 'm',
                          validator: _numarObligatoriu,
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CalcNumberField(
                          controller: _latime,
                          label: _tip.esteOrizontal
                              ? 'Adâncime'
                              : 'Lățime (pe pantă)',
                          suffix: 'm',
                          validator: _numarObligatoriu,
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                    ],
                  ),
                  if (cap != null) ...[
                    const SizedBox(height: 12),
                    _CardCapacitate(cap: cap),
                  ],
                  const SizedBox(height: 20),
                  const CalcSectionTitle(
                    'Structură',
                    icon: Icons.foundation_outlined,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _capriorSectiune,
                          decoration: const InputDecoration(
                            labelText: 'Secțiune căpriori',
                            hintText: 'ex. 10×12 cm',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CalcNumberField(
                          controller: _capriorInterax,
                          label: 'Interax',
                          suffix: 'cm',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  EnumDropdown<StarePlan>(
                    label: 'Starea structurii',
                    value: _stare,
                    values: StarePlan.values,
                    eticheta: (v) => v.eticheta,
                    onChanged: (v) => setState(() => _stare = v),
                  ),
                  const SizedBox(height: 20),
                  CalcSectionTitle(
                    'Obstacole și umbrire (${_obstacole.length})',
                    icon: Icons.filter_drama_outlined,
                  ),
                  for (final o in _obstacole)
                    Card(
                      child: ListTile(
                        dense: true,
                        leading: Icon(
                          Icons.crop_square,
                          color: context.accentOrange,
                        ),
                        title: Text(TipObstacol.dinCod(o.tip).eticheta),
                        subtitle: Text(
                          'înălțime ${formatNumar(o.inaltimeM)} m · la ${formatNumar(o.distantaM)} m'
                          '${o.observatii.isEmpty ? '' : ' · ${o.observatii}'}',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () async {
                            await ref
                                .read(releveuRepositoryProvider)
                                .stergeObstacol(o.id);
                            await _reincarcaObstacole();
                          },
                        ),
                      ),
                    ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: _adaugaObstacol,
                    icon: const Icon(Icons.add),
                    label: const Text('Adaugă obstacol'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _observatii,
                    maxLines: 3,
                    decoration: const InputDecoration(labelText: 'Observații'),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: _salveaza ? null : _salveazaPlan,
                    icon: const Icon(Icons.save_outlined),
                    label: Text(_editare ? 'Salvează' : 'Adaugă planul'),
                  ),
                ],
              ),
            ),
    );
  }
}

class _CardSenzori extends StatelessWidget {
  final CitireSenzori? citire;
  final bool activ;
  final VoidCallback onComuta;
  final VoidCallback onPreia;

  const _CardSenzori({
    required this.citire,
    required this.activ,
    required this.onComuta,
    required this.onPreia,
  });

  @override
  Widget build(BuildContext context) {
    final c = citire;
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        child: Row(
          children: [
            Icon(
              activ ? Icons.explore : Icons.explore_off,
              color: activ ? context.accentBlue : context.hintColor,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    c == null
                        ? 'Busolă și inclinometru'
                        : '${c.inclinareGrade.toStringAsFixed(0)}° înclinare'
                              '${c.busolaDisponibila ? ' · ${c.azimutFataDeSud.toStringAsFixed(0)}° (${SenzoriService.directie(c.azimutFataDeSud)})' : ''}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    c == null
                        ? 'Așază telefonul pe suprafață și pornește măsurarea'
                        : (c.busolaDisponibila
                              ? 'Ține telefonul lipit de plan, apoi preia valorile'
                              : 'Fără busolă pe acest telefon — completează azimutul manual'),
                    style: TextStyle(
                      fontSize: 12,
                      color: context.subtitleColor,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: onComuta,
              child: Text(activ ? 'Oprește' : 'Măsoară'),
            ),
            if (activ)
              FilledButton(onPressed: onPreia, child: const Text('Preia')),
          ],
        ),
      ),
    );
  }
}

class _CardCapacitate extends StatelessWidget {
  final CapacitatePlan cap;
  const _CardCapacitate({required this.cap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.infoSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.infoBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${cap.nrModule} module ≈ ${formatNumar(cap.kWp)} kWp',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: context.infoText,
            ),
          ),
          Text(
            '${cap.moduleOrizontal} × ${cap.moduleVertical} · suprafață utilă '
            '${formatNumar(cap.suprafataUtilaM2, zecimale: 1)} m² din ${formatNumar(cap.suprafataBrutaM2, zecimale: 1)} m²',
            style: TextStyle(fontSize: 12, color: context.infoText),
          ),
          for (final v in cap.verdicte)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                '• ${v.titlu}: ${v.detaliu}',
                style: TextStyle(fontSize: 11, color: context.subtitleColor),
              ),
            ),
        ],
      ),
    );
  }
}

class _ObstacolSheet extends StatefulWidget {
  final String planId;
  const _ObstacolSheet({required this.planId});

  @override
  State<_ObstacolSheet> createState() => _ObstacolSheetState();
}

class _ObstacolSheetState extends State<_ObstacolSheet> {
  TipObstacol _tip = TipObstacol.cos;
  final _inaltime = TextEditingController(text: '1');
  final _distanta = TextEditingController(text: '2');
  final _observatii = TextEditingController();

  @override
  void dispose() {
    _inaltime.dispose();
    _distanta.dispose();
    _observatii.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        0,
        16,
        16 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Obstacol',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          EnumDropdown<TipObstacol>(
            label: 'Tip',
            value: _tip,
            values: TipObstacol.values,
            eticheta: (v) => v.eticheta,
            onChanged: (v) => setState(() => _tip = v),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: CalcNumberField(
                  controller: _inaltime,
                  label: 'Înălțime peste plan',
                  suffix: 'm',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CalcNumberField(
                  controller: _distanta,
                  label: 'Distanță',
                  suffix: 'm',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _observatii,
            decoration: const InputDecoration(labelText: 'Observații'),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () => Navigator.pop(
              context,
              ObstacoleCompanion(
                planId: Value(widget.planId),
                tip: Value(_tip.cod),
                inaltimeM: Value(parseNumar(_inaltime.text) ?? 0),
                distantaM: Value(parseNumar(_distanta.text) ?? 0),
                observatii: Value(_observatii.text.trim()),
              ),
            ),
            child: const Text('Adaugă'),
          ),
        ],
      ),
    );
  }
}

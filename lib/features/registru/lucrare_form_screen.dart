import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/app_colors.dart';
import '../../app/providers.dart';
import '../../core/data/localitati_romania.dart';
import '../../core/db/database.dart';
import '../../core/models/enums.dart';
import '../../core/utils/format.dart';
import '../../widgets/calc_widgets.dart';
import '../../widgets/common_widgets.dart';
import '../clienti/client_picker_sheet.dart';

/// Creare (id == null) sau editare a unei fișe de lucrare: identificare,
/// beneficiar și loc de consum. Secțiunile tehnice vin în etapele următoare.
class LucrareFormScreen extends ConsumerStatefulWidget {
  final String? id;
  const LucrareFormScreen({super.key, this.id});

  @override
  ConsumerState<LucrareFormScreen> createState() => _LucrareFormScreenState();
}

class _LucrareFormScreenState extends ConsumerState<LucrareFormScreen> {
  final _form = GlobalKey<FormState>();
  bool _incarcat = false;
  bool _salveaza = false;

  // Identificare
  ClientiData? _client;
  RolClient _rol = RolClient.proprietar;
  TipLucrare _tip = TipLucrare.instalareNoua;
  final _titlu = TextEditingController();
  final _observatii = TextEditingController();

  // Loc de consum
  final _adresa = TextEditingController();
  final _localitate = TextEditingController();
  String _judet = '';
  OperatorDistributie _od = OperatorDistributie.ppc;
  final _pod = TextEditingController();
  NivelTensiune _nivel = NivelTensiune.jt;
  TipBransament _bransament = TipBransament.monofazat;
  final _putereAprobata = TextEditingController();
  final _putereContractata = TextEditingController();
  final _disjunctor = TextEditingController();
  SchemaLegarePamant _schemaLp = SchemaLegarePamant.necunoscuta;
  bool _prizaPamant = false;
  TipContor _contorTip = TipContor.necunoscut;
  final _contorSerie = TextEditingController();
  bool _contorBidirectional = false;
  DestinatieCladire _destinatie = DestinatieCladire.rezidential;
  final _anConstructie = TextEditingController();
  final _obsLoc = TextEditingController();

  bool get _editare => widget.id != null;

  @override
  void initState() {
    super.initState();
    if (_editare) {
      _incarca();
    } else {
      _incarcat = true;
    }
  }

  Future<void> _incarca() async {
    final fisa = await ref
        .read(lucrariRepositoryProvider)
        .watchFisa(widget.id!)
        .first;
    if (!mounted || fisa == null) return;
    final l = fisa.lucrare;
    final lc = fisa.locConsum;
    setState(() {
      _client = fisa.client;
      _rol = RolClient.dinCod(l.rolClient);
      _tip = TipLucrare.dinCod(l.tipLucrare);
      _titlu.text = l.titlu;
      _observatii.text = l.observatii;
      if (lc != null) {
        _adresa.text = lc.adresa;
        _localitate.text = lc.localitate;
        _judet = lc.judet;
        _od = OperatorDistributie.dinCod(lc.operatorDistributie);
        _pod.text = lc.codPod;
        _nivel = NivelTensiune.dinCod(lc.nivelTensiune);
        _bransament = TipBransament.dinCod(lc.bransament);
        _putereAprobata.text = lc.putereAprobataKva == null
            ? ''
            : formatNumar(lc.putereAprobataKva);
        _putereContractata.text = lc.putereContractataKw == null
            ? ''
            : formatNumar(lc.putereContractataKw);
        _disjunctor.text = lc.disjunctorGeneralA?.toString() ?? '';
        _schemaLp = SchemaLegarePamant.dinCod(lc.schemaLegarePamant);
        _prizaPamant = lc.prizaPamantProprie;
        _contorTip = TipContor.dinCod(lc.contorTip);
        _contorSerie.text = lc.contorSerie;
        _contorBidirectional = lc.contorBidirectional;
        _destinatie = DestinatieCladire.dinCod(lc.destinatieCladire);
        _anConstructie.text = lc.anConstructie?.toString() ?? '';
        _obsLoc.text = lc.observatii;
      }
      _incarcat = true;
    });
  }

  @override
  void dispose() {
    for (final c in [
      _titlu,
      _observatii,
      _adresa,
      _localitate,
      _pod,
      _putereAprobata,
      _putereContractata,
      _disjunctor,
      _contorSerie,
      _anConstructie,
      _obsLoc,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _alegeClient() async {
    final ales = await showClientPickerSheet(context);
    if (ales != null) setState(() => _client = ales);
  }

  Future<void> _salveazaFisa() async {
    if (!_form.currentState!.validate()) return;
    if (_client == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Alege beneficiarul fișei')));
      return;
    }
    setState(() => _salveaza = true);
    final lucrare = LucrariCompanion(
      clientId: Value(_client!.id),
      rolClient: Value(_rol.cod),
      tipLucrare: Value(_tip.cod),
      titlu: Value(_titlu.text.trim()),
      observatii: Value(_observatii.text.trim()),
    );
    final loc = LocuriConsumCompanion(
      adresa: Value(_adresa.text.trim()),
      localitate: Value(_localitate.text.trim()),
      judet: Value(_judet),
      operatorDistributie: Value(_od.cod),
      codPod: Value(_pod.text.trim().toUpperCase()),
      nivelTensiune: Value(_nivel.cod),
      bransament: Value(_bransament.cod),
      putereAprobataKva: Value(parseNumar(_putereAprobata.text)),
      putereContractataKw: Value(parseNumar(_putereContractata.text)),
      disjunctorGeneralA: Value(parseIntreg(_disjunctor.text)),
      schemaLegarePamant: Value(_schemaLp.cod),
      prizaPamantProprie: Value(_prizaPamant),
      contorTip: Value(_contorTip.cod),
      contorSerie: Value(_contorSerie.text.trim()),
      contorBidirectional: Value(_contorBidirectional),
      destinatieCladire: Value(_destinatie.cod),
      anConstructie: Value(parseIntreg(_anConstructie.text)),
      observatii: Value(_obsLoc.text.trim()),
    );
    final repo = ref.read(lucrariRepositoryProvider);
    String id;
    if (_editare) {
      id = widget.id!;
      await repo.actualizeaza(id: id, lucrare: lucrare, locConsum: loc);
    } else {
      id = await repo.creeaza(lucrare: lucrare, locConsum: loc);
    }
    if (!mounted) return;
    if (_editare) {
      context.pop();
    } else {
      context.pop();
      context.go('/registru/$id');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(_editare ? 'Editare fișă' : 'Fișă de lucrare nouă'),
      ),
      body: !_incarcat
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _form,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
                children: [
                  const CalcSectionTitle(
                    'Identificare',
                    icon: Icons.badge_outlined,
                  ),
                  _ClientTile(client: _client, onTap: _alegeClient),
                  const SizedBox(height: 12),
                  EnumDropdown<RolClient>(
                    label: 'Calitatea beneficiarului',
                    value: _rol,
                    values: RolClient.values,
                    eticheta: (v) => v.eticheta,
                    onChanged: (v) => setState(() => _rol = v),
                  ),
                  const SizedBox(height: 12),
                  EnumDropdown<TipLucrare>(
                    label: 'Tip lucrare',
                    value: _tip,
                    values: TipLucrare.values,
                    eticheta: (v) => v.eticheta,
                    onChanged: (v) => setState(() => _tip = v),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _titlu,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: 'Titlu (opțional)',
                      hintText: 'ex. Sistem hibrid 10 kWp cu stocare 10 kWh',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const CalcSectionTitle(
                    'Amplasament',
                    icon: Icons.place_outlined,
                  ),
                  TextFormField(
                    controller: _adresa,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: 'Adresă (stradă, număr)',
                    ),
                  ),
                  const SizedBox(height: 12),
                  _LocalitateField(
                    controller: _localitate,
                    judet: _judet,
                    onAles: (loc, judet) => setState(() {
                      _localitate.text = loc;
                      _judet = judet;
                    }),
                  ),
                  const SizedBox(height: 12),
                  EnumDropdown<DestinatieCladire>(
                    label: 'Destinația clădirii',
                    value: _destinatie,
                    values: DestinatieCladire.values,
                    eticheta: (v) => v.eticheta,
                    onChanged: (v) => setState(() => _destinatie = v),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _anConstructie,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'An construcție (opțional)',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const CalcSectionTitle(
                    'Racord și loc de consum',
                    icon: Icons.electrical_services_outlined,
                  ),
                  EnumDropdown<OperatorDistributie>(
                    label: 'Operator de distribuție (OD)',
                    value: _od,
                    values: OperatorDistributie.values,
                    eticheta: (v) => v.eticheta,
                    onChanged: (v) => setState(() => _od = v),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _pod,
                    textCapitalization: TextCapitalization.characters,
                    decoration: const InputDecoration(
                      labelText: 'Cod POD (punct de măsură)',
                      hintText: 'ex. RO001E…',
                    ),
                  ),
                  const SizedBox(height: 12),
                  CalcSegmented<TipBransament>(
                    label: 'Branșament',
                    selected: _bransament,
                    options: {
                      for (final b in TipBransament.values) b: b.eticheta,
                    },
                    onChanged: (v) => setState(() => _bransament = v),
                  ),
                  const SizedBox(height: 12),
                  EnumDropdown<NivelTensiune>(
                    label: 'Nivel de tensiune al racordului',
                    value: _nivel,
                    values: NivelTensiune.values,
                    eticheta: (v) => v.eticheta,
                    onChanged: (v) => setState(() => _nivel = v),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: CalcNumberField(
                          controller: _putereAprobata,
                          label: 'Putere aprobată',
                          suffix: 'kVA',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CalcNumberField(
                          controller: _putereContractata,
                          label: 'Putere contractată',
                          suffix: 'kW',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _disjunctor,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Disjunctor la punctul de delimitare',
                      suffixText: 'A',
                    ),
                  ),
                  const SizedBox(height: 12),
                  EnumDropdown<SchemaLegarePamant>(
                    label: 'Schema de legare la pământ',
                    value: _schemaLp,
                    values: SchemaLegarePamant.values,
                    eticheta: (v) => v.eticheta,
                    onChanged: (v) => setState(() => _schemaLp = v),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Priză de pământ proprie existentă'),
                    value: _prizaPamant,
                    onChanged: (v) => setState(() => _prizaPamant = v),
                  ),
                  const SizedBox(height: 8),
                  const CalcSectionTitle(
                    'Grup de măsură',
                    icon: Icons.speed_outlined,
                  ),
                  EnumDropdown<TipContor>(
                    label: 'Tip contor',
                    value: _contorTip,
                    values: TipContor.values,
                    eticheta: (v) => v.eticheta,
                    onChanged: (v) => setState(() => _contorTip = v),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _contorSerie,
                    decoration: const InputDecoration(
                      labelText: 'Serie contor',
                    ),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Contor bidirecțional (smart)'),
                    value: _contorBidirectional,
                    onChanged: (v) => setState(() => _contorBidirectional = v),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _obsLoc,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Observații amplasament',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _observatii,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Observații generale',
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: _salveaza ? null : _salveazaFisa,
                    icon: const Icon(Icons.save_outlined),
                    label: Text(
                      _editare ? 'Salvează modificările' : 'Deschide fișa',
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class _ClientTile extends StatelessWidget {
  final ClientiData? client;
  final VoidCallback onTap;
  const _ClientTile({required this.client, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final c = client;
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          c == null ? Icons.person_add_alt_1_outlined : Icons.person,
          color: c == null ? context.warningText : context.accentBlue,
        ),
        title: Text(c?.denumire ?? 'Alege beneficiarul'),
        subtitle: Text(
          c == null
              ? 'Obligatoriu — client existent sau nou'
              : [
                  TipClient.dinCod(c.tip).eticheta,
                  if (c.telefon.isNotEmpty) c.telefon,
                ].join(' · '),
        ),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

class _LocalitateField extends StatelessWidget {
  final TextEditingController controller;
  final String judet;
  final void Function(String localitate, String judet) onAles;

  const _LocalitateField({
    required this.controller,
    required this.judet,
    required this.onAles,
  });

  static final _sugestii = getSugestiiLocalitati();

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      initialValue: TextEditingValue(text: controller.text),
      optionsBuilder: (v) {
        final q = v.text.trim().toLowerCase();
        if (q.length < 2) return const Iterable.empty();
        return _sugestii.where((s) => s.toLowerCase().contains(q)).take(12);
      },
      onSelected: (s) =>
          onAles(getLocalitateaDinSuggestie(s), getJudetDinSuggestie(s) ?? ''),
      fieldViewBuilder: (context, textCtrl, focus, onSubmit) {
        textCtrl.addListener(() => controller.text = textCtrl.text);
        return TextFormField(
          controller: textCtrl,
          focusNode: focus,
          decoration: InputDecoration(
            labelText: 'Localitate',
            helperText: judet.isEmpty
                ? 'Alege din listă pentru județ'
                : 'Județ: $judet',
          ),
        );
      },
    );
  }
}

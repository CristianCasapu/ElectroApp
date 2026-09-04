import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/app_colors.dart';
import '../../app/providers.dart';
import '../../core/db/database.dart';
import '../../core/models/enums.dart';
import '../../core/services/contact_picker_service.dart';
import '../../widgets/calc_widgets.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/form_helpers.dart';

/// Creare (id == null) sau editare client. La creare returnează prin `pop`
/// id-ul clientului nou, pentru selectorul din fișa de lucrare.
///
/// Câmpurile comune tuturor tipurilor (nume, telefon, e-mail, adresă) se pot
/// lua din agenda telefonului sau din locația curentă; pentru persoanele
/// juridice, asociații și instituții datele se completează din registrul ANAF
/// pe baza CUI/CIF.
class ClientFormScreen extends ConsumerStatefulWidget {
  final String? id;
  const ClientFormScreen({super.key, this.id});

  @override
  ConsumerState<ClientFormScreen> createState() => _ClientFormScreenState();
}

class _ClientFormScreenState extends ConsumerState<ClientFormScreen> {
  final _form = GlobalKey<FormState>();
  bool _incarcat = false;
  bool _inexistent = false;
  bool _salveaza = false;
  bool _cautaAnaf = false;
  int _nrLucrari = 0;

  TipClient _tip = TipClient.persoanaFizica;
  final _denumire = TextEditingController();
  final _telefon = TextEditingController();
  final _email = TextEditingController();
  final _adresa = TextEditingController();
  final _cui = TextEditingController();
  final _regCom = TextEditingController();
  final _reprezentant = TextEditingController();
  String _furnizor = '';
  final _codClient = TextEditingController();
  final _codPod = TextEditingController();
  final _observatii = TextEditingController();

  bool get _editare => widget.id != null;
  bool get _estePj => _tip != TipClient.persoanaFizica;

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
    final repo = ref.read(clientiRepositoryProvider);
    final c = await repo.gaseste(widget.id!);
    final nr = await repo.numarLucrari(widget.id!);
    if (!mounted) return;
    if (c == null) {
      setState(() {
        _incarcat = true;
        _inexistent = true;
      });
      return;
    }
    setState(() {
      _tip = TipClient.dinCod(c.tip);
      _denumire.text = c.denumire;
      _telefon.text = c.telefon;
      _email.text = c.email;
      _adresa.text = c.adresaCorespondenta;
      _cui.text = c.cui;
      _regCom.text = c.regCom;
      _reprezentant.text = c.reprezentantLegal;
      _furnizor = c.furnizorEnergie;
      _codClient.text = c.codClientFurnizor;
      _codPod.text = c.codPod;
      _observatii.text = c.observatii;
      _nrLucrari = nr;
      _incarcat = true;
    });
  }

  @override
  void dispose() {
    for (final c in [
      _denumire,
      _telefon,
      _email,
      _adresa,
      _cui,
      _regCom,
      _reprezentant,
      _codClient,
      _codPod,
      _observatii,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _dinAgenda(ContactAles c) async {
    if (c.nume.isNotEmpty && _denumire.text.trim().isEmpty) {
      _denumire.text = c.nume;
    }
    final tel = await alegeDinLista(
      context,
      titlu: 'Telefon',
      optiuni: c.telefoane,
    );
    if (tel != null) _telefon.text = tel;
    if (!mounted) return;
    final mail = await alegeDinLista(
      context,
      titlu: 'E-mail',
      optiuni: c.emailuri,
    );
    if (mail != null) _email.text = mail;
    if (!mounted) return;
    final adr = await alegeDinLista(
      context,
      titlu: 'Adresă',
      optiuni: c.adrese,
    );
    if (adr != null) _adresa.text = adr;
    if (mounted) setState(() {});
  }

  Future<void> _dinAnaf() async {
    setState(() => _cautaAnaf = true);
    final anaf = ref.read(anafServiceProvider);
    final f = await anaf.cauta(_cui.text);
    if (!mounted) return;
    setState(() => _cautaAnaf = false);
    if (f == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(anaf.ultimaEroare ?? 'CUI negăsit')),
      );
      return;
    }
    setState(() {
      _cui.text = 'RO${f.cui}';
      if (f.denumire.isNotEmpty) _denumire.text = f.denumire;
      if (f.adresa.isNotEmpty) _adresa.text = f.adresa;
      if (f.nrRegCom.isNotEmpty) _regCom.text = f.nrRegCom;
      if (f.telefon.isNotEmpty && _telefon.text.trim().isEmpty) {
        _telefon.text = f.telefon;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'ANAF: ${f.denumire}'
          '${f.platitorTva ? ' · plătitor TVA' : ' · neplătitor TVA'}'
          '${f.inactiva ? ' · INACTIVĂ' : ''}',
        ),
      ),
    );
  }

  Future<void> _salveazaClient() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _salveaza = true);
    final date = ClientiCompanion(
      tip: Value(_tip.cod),
      denumire: Value(_denumire.text.trim()),
      telefon: Value(_telefon.text.trim()),
      email: Value(_email.text.trim()),
      adresaCorespondenta: Value(_adresa.text.trim()),
      cui: Value(_estePj ? _cui.text.trim().toUpperCase() : ''),
      regCom: Value(_estePj ? _regCom.text.trim() : ''),
      reprezentantLegal: Value(_estePj ? _reprezentant.text.trim() : ''),
      furnizorEnergie: Value(_furnizor),
      codClientFurnizor: Value(_codClient.text.trim()),
      codPod: Value(_codPod.text.trim().toUpperCase()),
      observatii: Value(_observatii.text.trim()),
    );
    final repo = ref.read(clientiRepositoryProvider);
    try {
      if (_editare) {
        await repo.actualizeaza(widget.id!, date);
        if (mounted) context.pop();
      } else {
        final id = await repo.creeaza(date);
        if (mounted) context.pop(id);
      }
    } on Object catch (e) {
      if (!mounted) return;
      setState(() => _salveaza = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Salvarea a eșuat: $e')));
    }
  }

  Future<void> _sterge() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ștergi clientul?'),
        content: Text(
          _nrLucrari > 0
              ? 'Clientul are $_nrLucrari fișe de lucrare și nu poate fi șters.'
              : 'Clientul „${_denumire.text}" va fi eliminat din listă.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Renunță'),
          ),
          if (_nrLucrari == 0)
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Șterge'),
            ),
        ],
      ),
    );
    if (ok != true) return;
    final reusit = await ref.read(clientiRepositoryProvider).sterge(widget.id!);
    if (!mounted) return;
    if (reusit) {
      context.pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Clientul are fișe asociate')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(_editare ? 'Editare client' : 'Client nou'),
        actions: [
          if (_editare)
            IconButton(
              tooltip: 'Șterge',
              icon: const Icon(Icons.delete_outline),
              onPressed: _sterge,
            ),
        ],
      ),
      body: !_incarcat
          ? const Center(child: CircularProgressIndicator())
          : _inexistent
          ? const StareGoala(
              icon: Icons.person_off_outlined,
              titlu: 'Clientul nu există',
              descriere: 'A fost șters sau nu a putut fi încărcat.',
            )
          : Form(
              key: _form,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
                children: [
                  CalcSegmented<TipClient>(
                    label: 'Tip beneficiar',
                    selected: _tip,
                    options: {
                      TipClient.persoanaFizica: 'Pers. fizică',
                      TipClient.persoanaJuridica: 'Pers. juridică',
                      TipClient.asociatie: 'Asociație',
                      TipClient.institutie: 'Instituție',
                    },
                    onChanged: (v) => setState(() => _tip = v),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      ContactButton(onAles: _dinAgenda),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Nume, telefon, e-mail și adresă din agenda telefonului',
                          style: TextStyle(
                            fontSize: 12,
                            color: context.subtitleColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (_estePj) ...[
                    const SizedBox(height: 16),
                    const CalcSectionTitle(
                      'Date juridice',
                      icon: Icons.business_outlined,
                    ),
                    TextFormField(
                      controller: _cui,
                      textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                        labelText: 'CUI / CIF',
                        helperText:
                            'Completează automat denumirea, adresa și Reg. Com. de la ANAF',
                        suffixIcon: _cautaAnaf
                            ? const Padding(
                                padding: EdgeInsets.all(12),
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              )
                            : IconButton(
                                tooltip: 'Caută la ANAF',
                                icon: Icon(
                                  Icons.travel_explore,
                                  color: context.accentBlue,
                                ),
                                onPressed: _dinAnaf,
                              ),
                      ),
                      onFieldSubmitted: (_) => _dinAnaf(),
                    ),
                    const SizedBox(height: 12),
                  ] else
                    const SizedBox(height: 16),
                  TextFormField(
                    controller: _denumire,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: _estePj ? 'Denumire' : 'Nume și prenume',
                    ),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Obligatoriu' : null,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _telefon,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: 'Telefon',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'E-mail',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  AdresaField(
                    controller: _adresa,
                    label: 'Adresă de corespondență',
                    onAdresa: (a) => _adresa.text = a.scurta,
                  ),
                  if (_estePj) ...[
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _regCom,
                      decoration: const InputDecoration(
                        labelText: 'Nr. Reg. Com.',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _reprezentant,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: 'Reprezentant legal',
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  const CalcSectionTitle('Energie', icon: Icons.bolt_outlined),
                  FurnizorField(
                    valoare: _furnizor,
                    onChanged: (v) => setState(() => _furnizor = v),
                    label: 'Furnizor curent',
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _codClient,
                          decoration: const InputDecoration(
                            labelText: 'Cod client',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _codPod,
                          textCapitalization: TextCapitalization.characters,
                          decoration: const InputDecoration(
                            labelText: 'Cod POD',
                            hintText: 'RO…',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _observatii,
                    maxLines: 3,
                    decoration: const InputDecoration(labelText: 'Observații'),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Notă: CNP-ul nu se stochează în aplicație; se completează '
                    'doar la generarea documentelor care îl cer.',
                    style: TextStyle(
                      fontSize: 12,
                      color: context.subtitleColor,
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: _salveaza ? null : _salveazaClient,
                    icon: const Icon(Icons.save_outlined),
                    label: Text(_editare ? 'Salvează' : 'Adaugă clientul'),
                  ),
                  if (_editare && _nrLucrari > 0) ...[
                    const SizedBox(height: 12),
                    Center(
                      child: Text(
                        '$_nrLucrari fișe de lucrare asociate',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}

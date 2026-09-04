import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/app_colors.dart';
import '../../app/providers.dart';
import '../../core/models/profil_firma.dart';
import '../../core/services/update_service.dart';
import '../../widgets/calc_widgets.dart';
import 'update_dialog.dart';

class SetariScreen extends ConsumerWidget {
  const SetariScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profil = ref.watch(profilFirmaProvider);
    final tema = ref.watch(themeModeProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Setări')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        children: [
          Card(
            child: ListTile(
              leading: Icon(Icons.business_outlined, color: context.accentBlue),
              title: const Text('Profil firmă și electrician'),
              subtitle: Text(
                profil.value?.esteCompletat == true
                    ? profil.value!.denumire.isNotEmpty
                          ? profil.value!.denumire
                          : profil.value!.electricianNume
                    : 'Necompletat — apare pe documentele emise',
              ),
              trailing: const Icon(Icons.chevron_right),
              // Pe navigatorul rădăcină, ca formularul să acopere și bara de tab-uri.
              onTap: () => Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(builder: (_) => const ProfilFirmaScreen()),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: CalcSegmented<ThemeMode>(
                label: 'Temă',
                selected: tema,
                options: const {
                  ThemeMode.system: 'Sistem',
                  ThemeMode.light: 'Luminoasă',
                  ThemeMode.dark: 'Întunecată',
                },
                onChanged: (m) =>
                    ref.read(themeModeProvider.notifier).seteaza(m),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const _DespreCard(),
        ],
      ),
    );
  }
}

class _DespreCard extends ConsumerStatefulWidget {
  const _DespreCard();

  @override
  ConsumerState<_DespreCard> createState() => _DespreCardState();
}

class _DespreCardState extends ConsumerState<_DespreCard> {
  bool _verifica = false;
  final _info = PackageInfo.fromPlatform();

  Future<void> _cautaActualizari() async {
    setState(() => _verifica = true);
    await verificaActualizari(
      context,
      service: ref.read(updateServiceProvider),
    );
    if (mounted) setState(() => _verifica = false);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: _verifica
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Icon(Icons.system_update, color: context.accentGreen),
            title: const Text('Caută actualizări'),
            subtitle: const Text('Instalare directă din GitHub Releases'),
            onTap: _verifica ? null : _cautaActualizari,
          ),
          FutureBuilder<PackageInfo>(
            future: _info,
            builder: (context, snap) {
              final v = snap.data;
              return ListTile(
                leading: Icon(Icons.info_outline, color: context.accentTeal),
                title: const Text('ElectroApp'),
                subtitle: Text(
                  v == null
                      ? 'Fișe de lucrare pentru sisteme fotovoltaice'
                      : 'Versiunea ${versiuneLocalaDin(v.version, v.buildNumber)}',
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.code, color: context.accentBlueGrey),
            title: const Text('Cod sursă și actualizări'),
            subtitle: const Text('github.com/CristianCasapu/ElectroApp'),
            onTap: () => launchUrl(
              Uri.parse(
                'https://github.com/CristianCasapu/ElectroApp/releases',
              ),
              mode: LaunchMode.externalApplication,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfilFirmaScreen extends ConsumerStatefulWidget {
  const ProfilFirmaScreen({super.key});

  @override
  ConsumerState<ProfilFirmaScreen> createState() => _ProfilFirmaScreenState();
}

class _ProfilFirmaScreenState extends ConsumerState<ProfilFirmaScreen> {
  final _c = <String, TextEditingController>{};
  bool _incarcat = false;

  static const _campuriFirma = [
    ('denumire', 'Denumire firmă', TextInputType.text),
    ('cui', 'CUI', TextInputType.text),
    ('regCom', 'Nr. Reg. Com.', TextInputType.text),
    ('adresa', 'Sediu', TextInputType.streetAddress),
    ('telefon', 'Telefon', TextInputType.phone),
    ('email', 'E-mail', TextInputType.emailAddress),
  ];
  static const _campuriAtestat = [
    ('atestatTip', 'Tip atestat ANRE (ex. B, Bi, C1A+C2A)', TextInputType.text),
    ('atestatNr', 'Număr atestat', TextInputType.text),
    ('atestatValabil', 'Valabil până la', TextInputType.datetime),
  ];
  static const _campuriElectrician = [
    ('electricianNume', 'Nume și prenume', TextInputType.name),
    ('electricianGrad', 'Grad autorizare (ex. IIB, IIIA)', TextInputType.text),
    ('electricianLegitimatie', 'Nr. legitimație', TextInputType.text),
    ('electricianValabil', 'Valabilă până la', TextInputType.datetime),
  ];

  @override
  void initState() {
    super.initState();
    for (final f in [
      ..._campuriFirma,
      ..._campuriAtestat,
      ..._campuriElectrician,
    ]) {
      _c[f.$1] = TextEditingController();
    }
    _incarca();
  }

  Future<void> _incarca() async {
    final p = await ref.read(setariRepositoryProvider).watchProfil().first;
    if (!mounted) return;
    _c['denumire']!.text = p.denumire;
    _c['cui']!.text = p.cui;
    _c['regCom']!.text = p.regCom;
    _c['adresa']!.text = p.adresa;
    _c['telefon']!.text = p.telefon;
    _c['email']!.text = p.email;
    _c['atestatTip']!.text = p.atestatTip;
    _c['atestatNr']!.text = p.atestatNr;
    _c['atestatValabil']!.text = p.atestatValabil;
    _c['electricianNume']!.text = p.electricianNume;
    _c['electricianGrad']!.text = p.electricianGrad;
    _c['electricianLegitimatie']!.text = p.electricianLegitimatie;
    _c['electricianValabil']!.text = p.electricianValabil;
    setState(() => _incarcat = true);
  }

  @override
  void dispose() {
    for (final c in _c.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _salveaza() async {
    String v(String k) => _c[k]!.text.trim();
    final p = ProfilFirma(
      denumire: v('denumire'),
      cui: v('cui').toUpperCase(),
      regCom: v('regCom'),
      adresa: v('adresa'),
      telefon: v('telefon'),
      email: v('email'),
      atestatTip: v('atestatTip'),
      atestatNr: v('atestatNr'),
      atestatValabil: v('atestatValabil'),
      electricianNume: v('electricianNume'),
      electricianGrad: v('electricianGrad'),
      electricianLegitimatie: v('electricianLegitimatie'),
      electricianValabil: v('electricianValabil'),
    );
    await ref.read(setariRepositoryProvider).salveazaProfil(p);
    if (mounted) Navigator.pop(context);
  }

  Widget _camp((String, String, TextInputType) f) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextFormField(
      controller: _c[f.$1],
      keyboardType: f.$3,
      decoration: InputDecoration(labelText: f.$2),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('Profil firmă')),
      body: !_incarcat
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
              children: [
                const CalcSectionTitle(
                  'Firma executantă',
                  icon: Icons.business_outlined,
                ),
                ..._campuriFirma.map(_camp),
                const CalcSectionTitle(
                  'Atestat ANRE (Ord. 134/2021)',
                  icon: Icons.verified_outlined,
                ),
                ..._campuriAtestat.map(_camp),
                const CalcSectionTitle(
                  'Electrician semnatar (Ord. 66/2023)',
                  icon: Icons.engineering_outlined,
                ),
                ..._campuriElectrician.map(_camp),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: _salveaza,
                  icon: const Icon(Icons.save_outlined),
                  label: const Text('Salvează profilul'),
                ),
              ],
            ),
    );
  }
}

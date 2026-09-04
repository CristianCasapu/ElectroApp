import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/app_colors.dart';
import '../../core/services/log_service.dart';
import '../../widgets/calc_widgets.dart';
import '../../widgets/common_widgets.dart';

/// Setări → Depanare: comutatorul jurnalului, nivelul, vizualizarea și
/// trimiterea fișierului de jurnal când utilizatorul raportează o problemă.
class JurnalScreen extends StatefulWidget {
  const JurnalScreen({super.key});

  @override
  State<JurnalScreen> createState() => _JurnalScreenState();
}

class _JurnalScreenState extends State<JurnalScreen> {
  NivelLog? _filtru;
  final _cautare = TextEditingController();

  @override
  void dispose() {
    _cautare.dispose();
    super.dispose();
  }

  Future<void> _trimite() async {
    final f = await log.pregatestePentruTrimitere();
    if (!mounted) return;
    if (f == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Jurnalul este gol')));
      return;
    }
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(f.path, mimeType: 'text/plain')],
        subject: 'ElectroApp — jurnal de depanare',
        text:
            'Jurnal de depanare ElectroApp. Descrie pe scurt ce ai făcut '
            'înainte de problemă și la ce oră s-a întâmplat.',
      ),
    );
    log.info('setari', 'Jurnal trimis');
  }

  Future<void> _copiaza() async {
    final text = await log.continut();
    final antet = await log.antetDiagnostic();
    await Clipboard.setData(ClipboardData(text: '$antet\n$text'));
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Jurnalul a fost copiat')));
  }

  Future<void> _sterge() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ștergi jurnalul?'),
        content: const Text(
          'Se șterg toate înregistrările de pe telefon. Datele lucrărilor '
          'nu sunt afectate.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Renunță'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Șterge'),
          ),
        ],
      ),
    );
    if (ok != true) return;
    await log.goleste();
    if (mounted) setState(() {});
  }

  bool _potrivire(IntrareLog e) {
    if (_filtru != null && !(e.nivel >= _filtru!)) return false;
    final q = _cautare.text.trim().toLowerCase();
    if (q.isEmpty) return true;
    return '${e.zona} ${e.mesaj} ${e.detaliu ?? ''}'.toLowerCase().contains(q);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Depanare'),
        actions: [
          IconButton(
            tooltip: 'Copiază',
            icon: const Icon(Icons.copy_all_outlined),
            onPressed: _copiaza,
          ),
          IconButton(
            tooltip: 'Șterge jurnalul',
            icon: const Icon(Icons.delete_outline),
            onPressed: _sterge,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'fab-jurnal',
        onPressed: _trimite,
        icon: const Icon(Icons.send_outlined),
        label: const Text('Trimite logurile'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
              child: Column(
                children: [
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Jurnal de activitate'),
                    subtitle: const Text(
                      'Înregistrează operațiile și erorile pe telefon',
                    ),
                    value: log.activ,
                    onChanged: (v) async {
                      await log.seteazaActiv(v);
                      if (mounted) setState(() {});
                    },
                  ),
                  CalcSegmented<NivelLog>(
                    label: 'Nivel înregistrat',
                    selected: log.nivel,
                    options: {for (final n in NivelLog.values) n: n.eticheta},
                    onChanged: (n) async {
                      await log.seteazaNivel(n);
                      if (mounted) setState(() {});
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Debug înregistrează tot (inclusiv fiecare calcul), Error '
                      'doar defectele. Jurnalul rămâne pe telefon până apeși '
                      '„Trimite logurile".',
                      style: TextStyle(
                        fontSize: 12,
                        color: context.subtitleColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _cautare,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Caută în jurnal',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _cautare.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => setState(_cautare.clear),
                      ),
              ),
            ),
          ),
          SizedBox(
            height: 46,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: const Text('Toate'),
                    selected: _filtru == null,
                    onSelected: (_) => setState(() => _filtru = null),
                  ),
                ),
                for (final n in NivelLog.values)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text('${n.eticheta}+'),
                      selected: _filtru == n,
                      onSelected: (v) => setState(() => _filtru = v ? n : null),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<int>(
              valueListenable: log.revizie,
              builder: (context, _, _) {
                final intrari = log.recente.reversed.where(_potrivire).toList();
                if (intrari.isEmpty) {
                  return StareGoala(
                    icon: Icons.article_outlined,
                    titlu: log.activ ? 'Jurnal gol' : 'Jurnalul este oprit',
                    descriere: log.activ
                        ? 'Folosește aplicația și revino aici — operațiile apar imediat.'
                        : 'Pornește-l din comutatorul de mai sus pentru a putea trimite loguri.',
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
                  itemCount: intrari.length,
                  separatorBuilder: (_, _) =>
                      Divider(height: 1, color: context.borderColor),
                  itemBuilder: (context, i) => _IntrareRand(intrari[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _IntrareRand extends StatelessWidget {
  final IntrareLog e;
  const _IntrareRand(this.e);

  @override
  Widget build(BuildContext context) {
    final culoare = switch (e.nivel) {
      NivelLog.debug => context.hintColor,
      NivelLog.info => context.accentBlue,
      NivelLog.warn => context.accentOrange,
      NivelLog.error => context.accentRed,
    };
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 34,
            margin: const EdgeInsets.only(right: 8, top: 2),
            decoration: BoxDecoration(
              color: culoare,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      e.ora,
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: context.hintColor,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      e.zona,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: culoare,
                      ),
                    ),
                  ],
                ),
                Text(e.mesaj, style: const TextStyle(fontSize: 13)),
                if (e.detaliu != null && e.detaliu!.isNotEmpty)
                  Text(
                    e.detaliu!,
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'monospace',
                      color: context.subtitleColor,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

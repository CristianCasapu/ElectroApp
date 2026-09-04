import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/app_colors.dart';
import '../../app/providers.dart';
import '../../core/db/database.dart';
import '../../core/db/solutii_repository.dart';
import '../../core/models/solutie.dart';
import '../../core/services/log_service.dart';
import '../../core/services/raport_pdf_service.dart';
import '../../core/utils/format.dart';
import '../../widgets/common_widgets.dart';
import 'solutie_widgets.dart';

/// O revizie salvată a soluției tehnice: rezultatul înghețat + emiterea
/// documentelor (fișa sistemului, oferte) din ea.
class SolutieDetailScreen extends ConsumerStatefulWidget {
  final String lucrareId;
  final String solutieId;
  const SolutieDetailScreen({
    super.key,
    required this.lucrareId,
    required this.solutieId,
  });

  @override
  ConsumerState<SolutieDetailScreen> createState() =>
      _SolutieDetailScreenState();
}

class _SolutieDetailScreenState extends ConsumerState<SolutieDetailScreen> {
  SolutiiData? _solutie;
  SolutieSnapshot? _snapshot;
  bool _incarcat = false;
  bool _genereaza = false;
  double _tva = 21;
  final _observatiiOferta = TextEditingController();

  @override
  void initState() {
    super.initState();
    _incarca();
  }

  Future<void> _incarca() async {
    final s = await ref
        .read(solutiiRepositoryProvider)
        .gaseste(widget.solutieId);
    if (!mounted) return;
    setState(() {
      _solutie = s;
      _snapshot = s == null ? null : SolutiiRepository.decodeaza(s);
      _incarcat = true;
    });
  }

  @override
  void dispose() {
    _observatiiOferta.dispose();
    super.dispose();
  }

  Future<void> _emite(TipDocument tip) async {
    final s = _solutie;
    final snap = _snapshot;
    final fisa = ref.read(fisaProvider(widget.lucrareId)).value;
    final profil = ref.read(profilFirmaProvider).value;
    if (s == null || snap == null || fisa == null || profil == null) return;
    setState(() => _genereaza = true);
    log.info('documente', 'Generez ${tip.eticheta}', 'revizia R${s.revizie}');
    try {
      final pdf = ref.read(raportPdfProvider);
      final bytes = tip == TipDocument.fisaSistem
          ? await pdf.fisaSistem(
              profil: profil,
              fisa: fisa,
              s: snap,
              revizie: s.revizie,
            )
          : await pdf.oferta(
              profil: profil,
              fisa: fisa,
              s: snap,
              revizie: s.revizie,
              tip: tip,
              tvaProcent: _tva,
              observatii: _observatiiOferta.text.trim(),
            );
      final repo = ref.read(solutiiRepositoryProvider);
      // versiunea următoare per tip și fișă
      final existente = await repo.watchDocumente(widget.lucrareId).first;
      final versiune =
          existente
              .where((d) => d.tip == tip.cod)
              .fold<int>(0, (m, d) => d.versiune > m ? d.versiune : m) +
          1;
      final f = await pdf.salveaza(
        bytes: bytes,
        nrInregistrare: fisa.lucrare.nrInregistrare,
        tip: tip,
        versiune: versiune,
      );
      final doc = await repo.adaugaDocument(
        lucrareId: widget.lucrareId,
        solutieId: s.id,
        tip: tip,
        cale: f.cale,
        sha256: f.sha256,
        marimeBytes: f.marime,
      );
      if (!mounted) return;
      await deschideDocument(context, doc);
    } on Object catch (e, st) {
      log.error('documente', 'Generarea ${tip.eticheta} a eșuat', e, st);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Generarea a eșuat: $e')));
      }
    } finally {
      if (mounted) setState(() => _genereaza = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = _solutie;
    final snap = _snapshot;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          s == null ? 'Soluție tehnică' : 'Soluție tehnică · R${s.revizie}',
        ),
        actions: [
          if (snap != null)
            IconButton(
              tooltip: 'Recalculează pornind de la această revizie',
              icon: const Icon(Icons.refresh),
              onPressed: () => context.push(
                '/registru/${widget.lucrareId}/estimare',
                extra: snap.intrari,
              ),
            ),
        ],
      ),
      body: !_incarcat
          ? const Center(child: CircularProgressIndicator())
          : (s == null || snap == null)
          ? const StareGoala(
              icon: Icons.folder_off_outlined,
              titlu: 'Revizia nu există',
              descriere: 'A fost ștearsă sau nu a putut fi încărcată.',
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
              children: [
                Card(
                  child: ListTile(
                    leading: Icon(Icons.history, color: context.accentBlue),
                    title: Text(
                      'Revizia R${s.revizie} · ${formatDataOra(s.creataLa)}',
                    ),
                    subtitle: Text(
                      s.observatii.isEmpty
                          ? snap.titluScurt
                          : '${snap.titluScurt}\n${s.observatii}',
                    ),
                    isThreeLine: s.observatii.isNotEmpty,
                  ),
                ),
                const SizedBox(height: 12),
                RezultatSolutieView(s: snap),
                const SizedBox(height: 16),
                SectiuneCard(
                  titlu: 'Emite documente',
                  icon: Icons.picture_as_pdf_outlined,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: formatNumar(_tva),
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              labelText: 'TVA',
                              suffixText: '%',
                            ),
                            onChanged: (v) => _tva = parseNumar(v) ?? _tva,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: _observatiiOferta,
                            decoration: const InputDecoration(
                              labelText: 'Observații pe ofertă',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final t in TipDocument.values)
                          FilledButton.tonalIcon(
                            onPressed: _genereaza ? null : () => _emite(t),
                            icon: Icon(
                              t == TipDocument.fisaSistem
                                  ? Icons.description_outlined
                                  : Icons.request_quote_outlined,
                              size: 18,
                            ),
                            label: Text(t.eticheta),
                          ),
                      ],
                    ),
                    if (_genereaza)
                      const Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: LinearProgressIndicator(),
                      ),
                  ],
                ),
              ],
            ),
    );
  }
}

/// Meniul unui document emis: previzualizare/tipărire sau trimitere.
Future<void> deschideDocument(BuildContext context, DocumenteData d) async {
  final f = File(d.cale);
  if (!await f.exists()) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fișierul PDF nu mai există pe telefon')),
      );
    }
    return;
  }
  if (!context.mounted) return;
  final actiune = await showModalBottomSheet<String>(
    context: context,
    showDragHandle: true,
    builder: (ctx) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              RaportPdfService.numeAfisat(d),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              '${formatDataOra(d.emisLa)} · ${(d.marimeBytes / 1024).toStringAsFixed(0)} KB · SHA-256 \${d.sha256.length > 12 ? d.sha256.substring(0, 12) : d.sha256}…',
            ),
          ),
          ListTile(
            leading: const Icon(Icons.print_outlined),
            title: const Text('Previzualizează / tipărește'),
            onTap: () => Navigator.pop(ctx, 'print'),
          ),
          ListTile(
            leading: const Icon(Icons.share_outlined),
            title: const Text('Trimite (WhatsApp, e-mail…)'),
            onTap: () => Navigator.pop(ctx, 'share'),
          ),
        ],
      ),
    ),
  );
  if (actiune == 'print') {
    final bytes = await f.readAsBytes();
    await Printing.layoutPdf(
      onLayout: (_) async => bytes,
      name: RaportPdfService.numeAfisat(d),
    );
  } else if (actiune == 'share') {
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(d.cale, mimeType: 'application/pdf')],
        subject: RaportPdfService.numeAfisat(d),
      ),
    );
  }
}

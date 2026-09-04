import 'dart:io';

import 'package:flutter/material.dart';

import '../../app/app_colors.dart';
import '../../core/services/update_service.dart';

/// Verifică GitHub Releases și, dacă există o versiune mai nouă, deschide
/// dialogul de descărcare/instalare. Cu [silentios] nu afișează nimic când
/// nu există actualizare sau când verificarea eșuează (pornirea aplicației).
Future<void> verificaActualizari(
  BuildContext context, {
  required UpdateService service,
  bool silentios = false,
}) async {
  final info = await service.verifica();
  if (!context.mounted) return;
  if (info == null) {
    if (!silentios) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(service.ultimaEroare ?? 'Ai ultima versiune.')),
      );
    }
    return;
  }
  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => UpdateDialog(info: info, service: service),
  );
}

class UpdateDialog extends StatefulWidget {
  final UpdateInfo info;
  final UpdateService service;
  const UpdateDialog({super.key, required this.info, required this.service});

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

enum _Faza { pregatit, descarca, gata, eroare }

class _UpdateDialogState extends State<UpdateDialog> {
  _Faza _faza = _Faza.pregatit;
  double _progres = 0;
  File? _apk;

  Future<void> _descarca() async {
    setState(() {
      _faza = _Faza.descarca;
      _progres = 0;
    });
    final f = await widget.service.descarca(
      widget.info,
      (p) => mounted ? setState(() => _progres = p) : null,
    );
    if (!mounted) return;
    setState(() {
      _apk = f;
      _faza = f == null ? _Faza.eroare : _Faza.gata;
    });
    if (f != null) await _instaleaza();
  }

  Future<void> _instaleaza() async {
    final ok = await widget.service.instaleaza(_apk!);
    if (!mounted) return;
    if (!ok) setState(() => _faza = _Faza.eroare);
  }

  @override
  Widget build(BuildContext context) {
    final i = widget.info;
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.system_update, color: context.accentGreen),
          const SizedBox(width: 8),
          Expanded(child: Text('Versiunea ${i.versiune}')),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (i.note.isNotEmpty)
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 220),
              child: SingleChildScrollView(
                child: Text(i.note, style: const TextStyle(fontSize: 13)),
              ),
            ),
          const SizedBox(height: 12),
          switch (_faza) {
            _Faza.pregatit => Text(
              'Descarcă ${i.numeFisier}${i.dimensiune.isEmpty ? '' : ' (${i.dimensiune})'} '
              'și instalează peste versiunea curentă. Datele rămân neatinse.',
              style: TextStyle(fontSize: 13, color: context.subtitleColor),
            ),
            _Faza.descarca => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LinearProgressIndicator(value: _progres),
                const SizedBox(height: 6),
                Text(
                  'Descărcare ${(_progres * 100).toStringAsFixed(0)} %',
                  style: TextStyle(fontSize: 12, color: context.subtitleColor),
                ),
              ],
            ),
            _Faza.gata => Text(
              'Descărcat. Dacă instalatorul nu s-a deschis, apasă „Instalează".',
              style: TextStyle(fontSize: 13, color: context.successText),
            ),
            _Faza.eroare => Text(
              'Descărcarea sau instalarea a eșuat. Poți lua APK-ul manual din '
              'pagina de release.',
              style: TextStyle(fontSize: 13, color: context.errorText),
            ),
          },
        ],
      ),
      actions: [
        TextButton(
          onPressed: _faza == _Faza.descarca
              ? null
              : () => Navigator.pop(context),
          child: const Text('Mai târziu'),
        ),
        switch (_faza) {
          _Faza.pregatit || _Faza.eroare => FilledButton.icon(
            onPressed: _descarca,
            icon: const Icon(Icons.download),
            label: Text(_faza == _Faza.eroare ? 'Reîncearcă' : 'Descarcă'),
          ),
          _Faza.descarca => const FilledButton(
            onPressed: null,
            child: Text('Se descarcă…'),
          ),
          _Faza.gata => FilledButton.icon(
            onPressed: _instaleaza,
            icon: const Icon(Icons.install_mobile),
            label: const Text('Instalează'),
          ),
        },
      ],
    );
  }
}

import 'package:flutter/material.dart';

/// Culori de identitate saturate — folosite ca fundal umplut (AppBar,
/// CalcButton, antet ResultCard) unde textul de deasupra este mereu alb.
/// Identice în ambele teme: albul are nevoie de un fundal saturat.
///
/// Pentru text / iconițe / borduri direct pe suprafață folosește
/// variantele adaptive `context.accent*` de mai jos.
class AccentFill {
  AccentFill._();

  static const Color blue = Color(0xFF1565C0);
  static const Color lightBlue = Color(0xFF0277BD);
  static const Color green = Color(0xFF2E7D32);
  static const Color amber = Color(0xFFF57F17);
  static const Color orange = Color(0xFFE65100);
  static const Color red = Color(0xFFC62828);
  static const Color purple = Color(0xFF6A1B9A);
  static const Color deepPurple = Color(0xFF4A148C);
  static const Color cyan = Color(0xFF00838F);
  static const Color teal = Color(0xFF00695C);
  static const Color blueGrey = Color(0xFF546E7A);
}

/// Adaptive semantic color helpers via BuildContext extension.
///
/// These helpers automatically adjust for light / dark themes using
/// Material 3 color tokens instead of hardcoded shade values.
///
/// Usage:
///   Container(
///     color: context.infoSurface,
///     child: Text('...', style: TextStyle(color: context.infoText)),
///   )
///
/// Import once per file:
///   import '../../theme/app_colors.dart';
extension AppColorsX on BuildContext {
  ColorScheme get _cs => Theme.of(this).colorScheme;
  bool get _dk => Theme.of(this).brightness == Brightness.dark;

  // ── Tinted surfaces ───────────────────────────────────────────────────────
  // Color.alphaBlend ensures the tint blends correctly over the current
  // surface (dark or light), so the same code works in both themes.

  /// Subtle blue/primary tint — info messages, hints, AI feature cards.
  Color get infoSurface => Color.alphaBlend(
    _cs.primary.withValues(alpha: _dk ? 0.18 : 0.08),
    _cs.surface,
  );

  /// Subtle green tint — success messages, "all ok" banners.
  Color get successSurface => Color.alphaBlend(
    const Color(0xFF4CAF50).withValues(alpha: _dk ? 0.18 : 0.08),
    _cs.surface,
  );

  /// Subtle amber/orange tint — warnings, optional steps, security cards.
  Color get warningSurface => Color.alphaBlend(
    const Color(0xFFFF8F00).withValues(alpha: _dk ? 0.22 : 0.09),
    _cs.surface,
  );

  /// Subtle red tint — errors, alerts.
  Color get errorSurface => Color.alphaBlend(
    _cs.error.withValues(alpha: _dk ? 0.18 : 0.08),
    _cs.surface,
  );

  /// Subtle purple tint — developer mode, experimental features.
  Color get devSurface => Color.alphaBlend(
    const Color(0xFF6A1B9A).withValues(alpha: _dk ? 0.22 : 0.09),
    _cs.surface,
  );

  /// Neutral elevated surface — replaces Colors.grey.shade50/100.
  Color get neutralSurface => _cs.surfaceContainerHighest;

  /// Suprafață subtil colorată cu orice accent — înlocuiește blend-urile
  /// manuale `Color.alphaBlend(x.withValues(alpha: isDark ? .. : ..), ..)`.
  Color tintedSurface(Color tint) =>
      Color.alphaBlend(tint.withValues(alpha: _dk ? 0.18 : 0.08), _cs.surface);

  // ── Semantic text / icon colors ───────────────────────────────────────────

  /// Primary-tinted text on infoSurface.
  Color get infoText => _dk ? const Color(0xFF90CAF9) : const Color(0xFF1565C0);

  /// Green text on successSurface.
  Color get successText => _dk ? Colors.green.shade300 : Colors.green.shade800;

  /// Orange text on warningSurface.
  Color get warningText =>
      _dk ? Colors.orange.shade300 : const Color(0xFFE65100);

  /// Error-toned text on errorSurface.
  Color get errorText =>
      _dk ? const Color(0xFFEF9A9A) : const Color(0xFFC62828);

  /// Purple text on devSurface.
  Color get devText => _dk ? Colors.purple.shade200 : Colors.purple.shade700;

  // ── Generic M3 semantic colors ────────────────────────────────────────────
  // These replace the most common hardcoded grey shades.

  /// Replaces Colors.grey.shade600/700 for secondary text.
  Color get subtitleColor => _cs.onSurfaceVariant;

  /// Replaces Colors.grey.shade400/500 for hint text, disabled icons.
  Color get hintColor => _cs.outline;

  /// Replaces Colors.grey.shade200/300 for borders, dividers.
  Color get borderColor => _cs.outlineVariant;

  // ── Border colors for tinted containers ──────────────────────────────────

  Color get infoBorder =>
      _dk ? _cs.primary.withValues(alpha: 0.35) : const Color(0xFFBBDEFB);
  Color get successBorder => _dk
      ? const Color(0xFF4CAF50).withValues(alpha: 0.35)
      : Colors.green.shade200;
  Color get warningBorder => _dk
      ? const Color(0xFFFF8F00).withValues(alpha: 0.35)
      : Colors.orange.shade200;
  Color get errorBorder =>
      _dk ? _cs.error.withValues(alpha: 0.35) : Colors.red.shade200;
  Color get devBorder => _dk
      ? const Color(0xFF6A1B9A).withValues(alpha: 0.35)
      : Colors.purple.shade200;

  // ── Status colors ─────────────────────────────────────────────────────────
  // Theme-adaptive: shade300 for dark (lighter = better contrast on dark bg),
  // shade700 for light (darker = better contrast on white bg).

  /// Returnează culoarea semantică a unui status document/estimare.
  Color statusColorFor(String status) {
    switch (status) {
      case 'trimisa':
        return _dk ? const Color(0xFF64B5F6) : const Color(0xFF1565C0);
      case 'acceptata':
        return _dk ? const Color(0xFF81C784) : const Color(0xFF2E7D32);
      case 'refuzata':
        return _dk ? const Color(0xFFE57373) : _cs.error;
      case 'finalizata':
        return _dk ? const Color(0xFF4DB6AC) : const Color(0xFF00695C);
      case 'anulata':
        return _cs.onSurfaceVariant;
      default: // draft
        return _dk ? const Color(0xFFFFB74D) : const Color(0xFFE65100);
    }
  }

  // ── Adaptive accents ──────────────────────────────────────────────────────
  // Variantele pe suprafață ale culorilor de identitate din AccentFill:
  // nuanță închisă (700/800) pe fundal deschis, pastel (200/300) pe întunecat.

  Color get accentBlue => _dk ? const Color(0xFF64B5F6) : AccentFill.blue;
  Color get accentLightBlue =>
      _dk ? const Color(0xFF4FC3F7) : AccentFill.lightBlue;
  Color get accentGreen => _dk ? const Color(0xFF81C784) : AccentFill.green;
  Color get accentAmber => _dk ? const Color(0xFFFFD54F) : AccentFill.amber;
  Color get accentOrange => _dk ? const Color(0xFFFFB74D) : AccentFill.orange;
  Color get accentRed => _dk ? const Color(0xFFEF9A9A) : AccentFill.red;
  Color get accentPurple => _dk ? const Color(0xFFCE93D8) : AccentFill.purple;
  Color get accentDeepPurple =>
      _dk ? const Color(0xFFB39DDB) : AccentFill.deepPurple;
  Color get accentCyan => _dk ? const Color(0xFF4DD0E1) : AccentFill.cyan;
  Color get accentTeal => _dk ? const Color(0xFF80CBC4) : AccentFill.teal;
  Color get accentBlueGrey =>
      _dk ? const Color(0xFF90A4AE) : AccentFill.blueGrey;

  /// Culoarea categoriei unui consumator electric (catalog materiale,
  /// calculator circuite).
  Color consumerCategoryColor(String cat) {
    switch (cat) {
      case 'iluminat':
        return accentAmber;
      case 'electrocasnice':
        return accentBlue;
      case 'climatizare':
        return accentLightBlue;
      case 'incalzire':
        return accentRed;
      case 'ev':
        return accentGreen;
      default: // altele
        return accentPurple;
    }
  }

  /// Culoarea semantică a statusului unui client (favorit, inactiv, etc.).
  Color clientStatusColor(String status) {
    switch (status) {
      case 'favorit':
        return _dk ? const Color(0xFFFFD54F) : const Color(0xFFFFA000);
      case 'inactiv':
        return _cs.onSurfaceVariant;
      case 'neprietenos':
        return _dk ? const Color(0xFFFF8A65) : const Color(0xFFE64A19);
      case 'rau_platnic':
        return _dk ? const Color(0xFFE57373) : const Color(0xFFD32F2F);
      default: // activ
        return accentGreen;
    }
  }

  // ── Functional semantic colors ────────────────────────────────────────────

  /// Culoare pentru elemente AI / Gemini (tertiary — violet în ambele teme).
  Color get aiColor => _cs.tertiary;

  /// Culoare text pe fundal AI (on tertiary).
  Color get aiOnColor => _cs.onTertiary;

  /// Culoare pentru suma materiale / categorie secundară.
  Color get materialsColor => _cs.secondary;

  /// Highlight financiar principal (total general, sume importante).
  Color get financialColor => _cs.primary;

  /// Culoare pentru stare de succes (confirmare, salvat, PDF generat).
  Color get successColor => accentGreen;

  /// Culoare pentru taxe (TVA) — portocaliu adaptat temei.
  Color get taxColor => accentOrange;

  /// Culoare pentru elementul dezactivat (M3 standard: 38% opacity).
  Color get disabledColor => _cs.onSurface.withValues(alpha: 0.38);

  /// Culoare chip/badge categorie 1 — prize, surse principale.
  Color get cat1Color => _cs.primary;

  /// Culoare chip/badge categorie 2 — întrerupătoare, elemente secundare.
  Color get cat2Color => _cs.secondary;

  /// Culoare chip/badge categorie 3 — iluminat, camere.
  Color get cat3Color => _cs.tertiary;

  /// Culoare chip/badge categorie 4 — circuite, diverse.
  Color get cat4Color => accentOrange;
}

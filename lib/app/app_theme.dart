import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// ============================================================
/// ElectroApp — App Theme (preluată din ElectroCalc)
/// Inspired by Samsung One UI 6 Design System
///
/// Light: pure white surfaces, Samsung Blue primary
/// Dark:  OLED pure-black bg (#000), elevated cards (#1C1C1C)
///
/// Ambele teme sunt construite din același builder (_build), astfel
/// încât fiecare componentă este definită identic structural în
/// ambele — doar culorile din ColorScheme diferă.
/// ============================================================
class AppTheme {
  static const ColorScheme _lightScheme = ColorScheme(
    brightness: Brightness.light,
    // ── Primary ──
    primary: Color(0xFF1259C3),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFD9E8FF),
    onPrimaryContainer: Color(0xFF001947),
    // ── Secondary ──
    secondary: Color(0xFF00897B),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFC8F0E8),
    onSecondaryContainer: Color(0xFF002020),
    // ── Tertiary ──
    tertiary: Color(0xFF6750A4),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFEADDFF),
    onTertiaryContainer: Color(0xFF21005D),
    // ── Error ──
    error: Color(0xFFE53935),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF93000A),
    // ── Surface / Background ──
    surface: Color(0xFFFFFFFF), // pure white card
    onSurface: Color(0xFF000000),
    surfaceContainerHighest: Color(0xFFF4F4F4), // second-level bg
    onSurfaceVariant: Color(0xFF666666), // secondary text
    // ── Outline ──
    outline: Color(0xFF999999),
    outlineVariant: Color(0xFFE6E6E6),
    // ── Misc ──
    inverseSurface: Color(0xFF1C1C1C),
    onInverseSurface: Color(0xFFFFFFFF),
    inversePrimary: Color(0xFF4A90E2),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    surfaceTint: Color(0xFF1259C3),
  );

  // One UI dark: OLED pure-black bg, elevated dark-grey cards,
  // slightly lighter Samsung Blue, green secondary.
  static const ColorScheme _darkScheme = ColorScheme(
    brightness: Brightness.dark,
    // ── Primary ──
    primary: Color(0xFF4A90E2), // lighter blue for dark bg
    onPrimary: Color(0xFF000000),
    primaryContainer: Color(0xFF1259C3),
    onPrimaryContainer: Color(0xFFD9E8FF),
    // ── Secondary ──
    secondary: Color(0xFF34C759), // vibrant green on dark
    onSecondary: Color(0xFF000000),
    secondaryContainer: Color(0xFF00897B),
    onSecondaryContainer: Color(0xFFC8F0E8),
    // ── Tertiary ──
    tertiary: Color(0xFFBB86FC),
    onTertiary: Color(0xFF000000),
    tertiaryContainer: Color(0xFF6750A4),
    onTertiaryContainer: Color(0xFFEADDFF),
    // ── Error ──
    error: Color(0xFFFF453A),
    onError: Color(0xFF000000),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),
    // ── Surface / Background ──
    surface: Color(0xFF1C1C1C), // card surfaces on OLED black
    onSurface: Color(0xFFFFFFFF),
    surfaceContainerHighest: Color(0xFF2C2C2C), // second-level elements
    onSurfaceVariant: Color(0xFF8E8E93), // secondary text
    // ── Outline ──
    outline: Color(0xFF636366),
    outlineVariant: Color(0xFF3A3A3C),
    // ── Misc ──
    inverseSurface: Color(0xFFF4F4F4),
    onInverseSurface: Color(0xFF000000),
    inversePrimary: Color(0xFF1259C3),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    surfaceTint: Color(0xFF4A90E2),
  );

  static final ThemeData lightTheme = _build(
    scheme: _lightScheme,
    scaffoldBackground: const Color(0xFFF4F4F4), // One UI page bg
    appBarBackground: const Color(0xFF1259C3),
  );

  static final ThemeData darkTheme = _build(
    scheme: _darkScheme,
    scaffoldBackground: const Color(0xFF000000), // OLED black
    appBarBackground: const Color(0xFF000000), // pure black AppBar
  );

  static ThemeData _build({
    required ColorScheme scheme,
    required Color scaffoldBackground,
    required Color appBarBackground,
  }) {
    final dark = scheme.brightness == Brightness.dark;
    // Dark: câmpurile au nevoie de un nivel de elevație peste cardul #1C1C1C.
    // Light: cardul e alb, deci și câmpul rămâne alb.
    final inputFill = dark ? scheme.surfaceContainerHighest : scheme.surface;
    // Albastrul saturat funcționează ca fundal selectat în ambele teme
    // (în dark, primary e pastel — contrast slab pentru text alb).
    final selectedFill = dark ? scheme.primaryContainer : scheme.primary;

    OutlineInputBorder inputBorder(Color color, {double width = 1}) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: color, width: width),
        );

    return ThemeData(
      useMaterial3: true,
      brightness: scheme.brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scaffoldBackground,
      fontFamily: 'Roboto',

      // ── AppBar ────────────────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: appBarBackground,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),

      // ── TabBar (folosit în AppBar — fundal colorat/negru) ────────────────
      tabBarTheme: TabBarThemeData(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withValues(alpha: 0.7),
        indicatorColor: Colors.white,
        dividerColor: Colors.transparent,
      ),

      // ── Cards ─────────────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        elevation: 0, // One UI uses flat cards
        color: scheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // One UI uses 16dp
        ),
        margin: EdgeInsets.zero,
      ),

      // ── Buttons ───────────────────────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50), // capsule — One UI style
          ),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          elevation: 0,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.primary,
          side: BorderSide(color: scheme.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),

      // ── FAB ───────────────────────────────────────────────────────────────
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        elevation: 2,
      ),

      // ── Input fields ──────────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        border: inputBorder(scheme.outlineVariant),
        enabledBorder: inputBorder(scheme.outlineVariant),
        focusedBorder: inputBorder(scheme.primary, width: 2),
        errorBorder: inputBorder(scheme.error),
        focusedErrorBorder: inputBorder(scheme.error, width: 2),
        filled: true,
        fillColor: inputFill,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        labelStyle: TextStyle(color: scheme.onSurfaceVariant),
        hintStyle: TextStyle(color: scheme.outline),
        helperStyle: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12),
      ),

      // ── Navigation bar ────────────────────────────────────────────────────
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        indicatorColor: scheme.primary.withValues(alpha: dark ? 0.20 : 0.12),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          // 11sp + letterSpacing negativ: 6 destinații pe ecran îngust —
          // „Calculator" trebuie să încapă pe un singur rând
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
              color: scheme.primary,
              fontSize: 11,
              letterSpacing: -0.3,
              fontWeight: FontWeight.w600,
            );
          }
          return TextStyle(
            fontSize: 11,
            letterSpacing: -0.3,
            color: scheme.onSurfaceVariant,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: scheme.primary);
          }
          return IconThemeData(color: scheme.onSurfaceVariant);
        }),
      ),

      // ── Chips ─────────────────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        shape: const StadiumBorder(), // fully rounded — One UI style
        backgroundColor: scheme.surfaceContainerHighest,
        selectedColor: selectedFill,
        checkmarkColor: Colors.white,
        labelStyle: TextStyle(fontSize: 13, color: scheme.onSurface),
      ),

      // ── Dialogs / sheets / menus ──────────────────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        titleTextStyle: TextStyle(
          color: scheme.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        modalBackgroundColor: scheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        dragHandleColor: scheme.outlineVariant,
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: scheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      // ── SnackBar ──────────────────────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: TextStyle(color: scheme.onInverseSurface),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      // ── Divider / slider / progress ───────────────────────────────────────
      dividerTheme: DividerThemeData(
        space: 1,
        thickness: 1,
        color: scheme.outlineVariant,
      ),
      sliderTheme: SliderThemeData(
        thumbColor: scheme.primary,
        activeTrackColor: scheme.primary,
        inactiveTrackColor: scheme.outlineVariant,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: scheme.primary),

      // ── List tile ─────────────────────────────────────────────────────────
      listTileTheme: ListTileThemeData(
        textColor: scheme.onSurface,
        iconColor: scheme.onSurfaceVariant,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand colors — Aubergine (grape skin) on matte violet-black
  static const _aubergine = Color(0xFF6B3A51);
  static const _nude = Color(0xFFD4B5A0);
  static const _darkBg = Color(0xFF14101A);
  static const _darkSurface = Color(0xFF1C1722);
  static const _darkCard = Color(0xFF241D2C);
  static const _darkBorder = Color(0xFF2E2636);
  static const _textPrimary = Color(0xFFF2ECEF);
  static const _textSecondary = Color(0xFF9A8F98);
  static const _textTertiary = Color(0xFF6A5F68);

  static ThemeData get dark {
    final colorScheme = ColorScheme.dark(
      primary: _aubergine,
      onPrimary: _textPrimary,
      primaryContainer: _aubergine.withValues(alpha: 0.18),
      onPrimaryContainer: _nude,
      secondary: _nude,
      onSecondary: Colors.black,
      surface: _darkBg,
      surfaceContainer: _darkSurface,
      onSurface: _textPrimary,
      onSurfaceVariant: _textSecondary,
      outline: _textTertiary,
      outlineVariant: _darkBorder,
      error: const Color(0xFFCF6679),
      tertiary: _nude,
    );

    final textTheme = GoogleFonts.interTextTheme(ThemeData.dark().textTheme);

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: _darkBg,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: _darkBg,
        foregroundColor: _textPrimary,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: _nude,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: _nude),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _nude,
        foregroundColor: Colors.black,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return _nude.withValues(alpha: 0.2);
            }
            return _darkCard;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return _nude;
            return _textSecondary;
          }),
          side: WidgetStateProperty.all(
            BorderSide(color: _darkBorder, width: 0.5),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: _nude,
        inactiveTrackColor: _darkBorder,
        thumbColor: _nude,
        overlayColor: _nude.withValues(alpha: 0.12),
        trackHeight: 3,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: _darkCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: _darkBorder, width: 0.5),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _darkCard,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _darkBorder, width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _darkBorder, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _nude, width: 1.5),
        ),
        labelStyle: TextStyle(color: _textSecondary),
        hintStyle: TextStyle(color: _textTertiary),
        prefixIconColor: _nude,
      ),
      dividerTheme: DividerThemeData(color: _darkBorder, thickness: 0.5),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: _darkSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
    );
  }

  // Keep light as fallback but dark is default
  static ThemeData get light => dark;
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand colors
  static const _gold = Color(0xFFD4A853);
  static const _darkBg = Color(0xFF0F0F0F);
  static const _darkSurface = Color(0xFF1A1A1A);
  static const _darkCard = Color(0xFF222222);
  static const _darkBorder = Color(0xFF2E2E2E);
  static const _textPrimary = Color(0xFFF5F5F5);
  static const _textSecondary = Color(0xFF999999);
  static const _textTertiary = Color(0xFF666666);

  static ThemeData get dark {
    final colorScheme = ColorScheme.dark(
      primary: _gold,
      onPrimary: Colors.black,
      primaryContainer: _gold.withValues(alpha: 0.15),
      onPrimaryContainer: _gold,
      secondary: const Color(0xFF8B5E3C),
      surface: _darkBg,
      surfaceContainer: _darkSurface,
      onSurface: _textPrimary,
      onSurfaceVariant: _textSecondary,
      outline: _textTertiary,
      outlineVariant: _darkBorder,
      error: const Color(0xFFCF6679),
      tertiary: const Color(0xFFD4A017),
    );

    final textTheme = GoogleFonts.dmSansTextTheme(ThemeData.dark().textTheme);

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
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: _darkSurface,
        indicatorColor: _gold.withValues(alpha: 0.2),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: _gold, size: 24);
          }
          return IconThemeData(color: _textTertiary, size: 24);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
                color: _gold, fontSize: 12, fontWeight: FontWeight.w600);
          }
          return TextStyle(color: _textTertiary, fontSize: 12);
        }),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: _gold,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: _gold),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _gold,
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
              return _gold.withValues(alpha: 0.2);
            }
            return _darkCard;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return _gold;
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
        activeTrackColor: _gold,
        inactiveTrackColor: _darkBorder,
        thumbColor: _gold,
        overlayColor: _gold.withValues(alpha: 0.12),
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
          borderSide: BorderSide(color: _gold, width: 1.5),
        ),
        labelStyle: TextStyle(color: _textSecondary),
        hintStyle: TextStyle(color: _textTertiary),
        prefixIconColor: _gold,
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

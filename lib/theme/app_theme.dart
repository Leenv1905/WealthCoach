import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFF006948);
  static const Color secondary = Color(0xFFBB0112);
  static const Color background = Color(0xFFF5FBF5);
  static const Color surface = Colors.white;

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: background,
    primaryColor: primary,
    colorScheme: ColorScheme.light(
      primary: primary,
      secondary: secondary,
      surface: surface,
      background: background,
      onPrimary: Colors.white,
      onSurface: const Color(0xFF171D19),
      onSurfaceVariant: const Color(0xFF3D4A42),
    ),
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.hankenGrotesk(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.02,
      ),
      headlineMedium: GoogleFonts.hankenGrotesk(
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: GoogleFonts.inter(fontSize: 14),
      bodySmall: GoogleFonts.inter(
        fontSize: 13,
        color: const Color(0xFF3D4A42),
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
      ),
    ),
    cardTheme: const CardThemeData(
      elevation: 3,
      shadowColor: Color.fromRGBO(0, 105, 72, 0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 8,
    ),
  );
}
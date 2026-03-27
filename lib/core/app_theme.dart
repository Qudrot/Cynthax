import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.danger,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.inter( // H1
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: AppColors.textBody,
        ),
        headlineMedium: GoogleFonts.inter( // H2
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.textBody,
        ),
        titleLarge: GoogleFonts.inter( // H3
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColors.textBody,
        ),
        bodyLarge: GoogleFonts.roboto( // Body Text
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.textBody,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.roboto( // Small Text
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textSubtleDark,
        ),
        labelLarge: GoogleFonts.roboto( // Button Text
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.professionalWhite,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.professionalWhite,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
         style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 2),
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shadowColor: Colors.black.withOpacity(0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.subtleGrey, width: 1), // Thin crisp border
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.professionalWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.subtleGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.subtleGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        hintStyle: GoogleFonts.roboto(
          color: AppColors.textSubtleDark,
          fontSize: 16,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}

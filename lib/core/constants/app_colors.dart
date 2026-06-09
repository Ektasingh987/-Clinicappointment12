import 'package:flutter/material.dart';

/// AppColors defines the color palette used throughout the MediBook app.
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // Primary Palette
  static const Color primary = Color(0xFF0D9488); // Teal 600
  static const Color secondary = Color(0xFF0F172A); // Slate 900
  static const Color accent = Color(0xFFF59E0B); // Amber 500

  // Backgrounds
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color backgroundDark = Color(0xFF0F172A);

  // Cards
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF1E293B);

  // Text
  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF64748B);
  static const Color textPrimaryDark = Color(0xFFF1F5F9);
  static const Color textSecondaryDark = Color(0xFF94A3B8);

  // Status/Feedback
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF22C55E);

  // Gradients
  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primary, secondary],
  );
}

import 'package:flutter/material.dart';

class CrayonTheme {
  // Warm earthy palette
  static const Color forestGreen = Color(0xFF2D5016);
  static const Color mustardYellow = Color(0xFFE6B800);
  static const Color brickRed = Color(0xFFB85450);
  static const Color cream = Color(0xFFFFF8E7);
  static const Color lightCream = Color(0xFFFFFDF5);
  static const Color darkBrown = Color(0xFF3E2723);
  
  // Additional colors for variety
  static const Color softGreen = Color(0xFF6B8E23);
  static const Color goldenYellow = Color(0xFFFFD700);
  
  // Custom text style with rounded, childlike typography
  static TextStyle get childlikeText => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    color: darkBrown,
    fontFamily: 'ComicNeue', // We'll use a rounded font or create custom
  );
  
  static TextStyle get childlikeBold => TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
    color: darkBrown,
  );
  
  static TextStyle get childlikeSmall => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.3,
    color: darkBrown,
  );
}


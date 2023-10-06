import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFF000000);
const Color secondaryColor = Color(0xFFECCF71);
const Color accentColor = Color(0xFF1A1A1A);
const Color mutedColor = Color(0xFFCCCCCC);

final TextTheme myTextTheme = TextTheme(
  displayLarge: GoogleFonts.poppins(
      fontSize: 92,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
      color: Colors.white),
  displayMedium: GoogleFonts.poppins(
      fontSize: 57,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
      color: Colors.white),
  displaySmall: GoogleFonts.poppins(
      fontSize: 46, fontWeight: FontWeight.w400, color: Colors.white),
  headlineMedium: GoogleFonts.poppins(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Colors.white),
  headlineSmall: GoogleFonts.poppins(
      fontSize: 23, fontWeight: FontWeight.w400, color: Colors.white),
  titleLarge: GoogleFonts.poppins(
      fontSize: 19,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: Colors.white),
  titleMedium: GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      color: Colors.white),
  titleSmall: GoogleFonts.poppins(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: Colors.white),
  bodyLarge: GoogleFonts.kumbhSans(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Colors.white),
  bodyMedium: GoogleFonts.kumbhSans(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Colors.white),
  labelLarge: GoogleFonts.kumbhSans(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
      color: Colors.white),
  bodySmall: GoogleFonts.kumbhSans(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: Colors.white),
  labelSmall: GoogleFonts.kumbhSans(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
      color: Colors.white),
);

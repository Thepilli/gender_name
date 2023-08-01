import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme() {
  return ThemeData(scaffoldBackgroundColor: Colors.white, appBarTheme: appBarTheme());
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
      color: Colors.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.grey),
      titleTextStyle: GoogleFonts.poppins(fontSize: 18, color: Colors.grey));
}

InputDecorationTheme inputDecorationTheme() {
  return const InputDecorationTheme();
}

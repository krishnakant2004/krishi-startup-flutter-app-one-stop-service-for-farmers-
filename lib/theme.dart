import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

class AppTheme {
  // Light Theme Data for Material 3
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.green, // Base color for the scheme
      brightness: Brightness.light,
    ),
    useMaterial3: true, // Enabling Material 3
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.white, // AppBar M3 style
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        padding:const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.blue,
        textStyle: TextStyle(fontSize: 16),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.blue,
        side: const BorderSide(color: Colors.blue),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      ),
    ),
    cardTheme: CardTheme(
      surfaceTintColor: Colors.white,
      color: Colors.grey[100],
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      shape: StadiumBorder(),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.montserrat( //Large headers
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: Colors.black87, // default
        letterSpacing: -1.5,
        height: 1.1,
      ),
      displayMedium: GoogleFonts.montserrat( // headers
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
        letterSpacing: -0.5,
        height: 1.1,
      ),
      displaySmall: GoogleFonts.montserrat( // Sub Headers
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
        letterSpacing: 0,
        height: 1.1,
      ),
      headlineLarge: GoogleFonts.montserrat(  // Section Headers
        fontSize: 32,
        fontWeight: FontWeight.w600, // bold
        color: Colors.black87,
        letterSpacing: 0,
        height: 1.2,
      ),
      headlineMedium: GoogleFonts.montserrat(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
        letterSpacing: 0,
        height: 1.2,
      ),
      headlineSmall: GoogleFonts.montserrat(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
        letterSpacing: 0,
        height: 1.2,
      ),
      titleLarge: GoogleFonts.poppins( // card titles
        fontSize: 22,
        fontWeight: FontWeight.w500, // Medium for titles
        color: Colors.black87,
        letterSpacing: 0,
        height: 1.2,
      ),
      titleMedium: GoogleFonts.poppins( //  titles
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
        letterSpacing: 0.15,
        height: 1.2,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
        letterSpacing: 0.1,
        height: 1.2,
      ),
      bodyLarge: GoogleFonts.lato( // Normal body text
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.black87,
        letterSpacing: 0.15,
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.lato(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.black87,
        letterSpacing: 0.25,
        height: 1.5,
      ),
      bodySmall: GoogleFonts.lato(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Colors.black87,
        letterSpacing: 0.4,
        height: 1.5,
      ),
      labelLarge: GoogleFonts.poppins(  // Button text
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white, // Button text color (light background)
        letterSpacing: 0.1,
        height: 1.2,
      ),
      labelMedium: GoogleFonts.poppins(  // Text for smaller labels
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
        letterSpacing: 0.1,
        height: 1.2,
      ),
      labelSmall: GoogleFonts.poppins(  // Text for Captions and tags
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.grey, // or a secondary color
        letterSpacing: 0.2,
        height: 1.2,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.black,
    ),
  );

  // Dark Theme Data for Material 3
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple, // Base color for dark scheme
      brightness: Brightness.dark,
    ),
    useMaterial3: true, // Enabling Material 3
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.black,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.deepPurple,
        textStyle: TextStyle(fontSize: 16),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.deepPurple,
        side: BorderSide(color: Colors.deepPurple),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      ),
    ),
    cardTheme: CardTheme(
      surfaceTintColor: Colors.black,
      color: Colors.grey[800],
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[700],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.deepPurple),
      ),
      labelStyle: TextStyle(color: Colors.grey[400]),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.deepPurple, width: 2),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
      shape: StadiumBorder(),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
          fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 16, color: Colors.white70),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.grey,
    ),
  );



//text theme
  TextTheme textTheme=TextTheme(
      displayLarge: GoogleFonts.montserrat( //Large headers
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: Colors.black87, // default
        letterSpacing: -1.5,
        height: 1.1,
      ),
      displayMedium: GoogleFonts.montserrat( // headers
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
        letterSpacing: -0.5,
        height: 1.1,
      ),
      displaySmall: GoogleFonts.montserrat( // Sub Headers
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
        letterSpacing: 0,
        height: 1.1,
      ),
      headlineLarge: GoogleFonts.montserrat(  // Section Headers
        fontSize: 32,
        fontWeight: FontWeight.w600, // bold
        color: Colors.black87,
        letterSpacing: 0,
        height: 1.2,
      ),
      headlineMedium: GoogleFonts.montserrat(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
        letterSpacing: 0,
        height: 1.2,
      ),
      headlineSmall: GoogleFonts.montserrat(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
        letterSpacing: 0,
        height: 1.2,
      ),
      titleLarge: GoogleFonts.poppins( // card titles
        fontSize: 22,
        fontWeight: FontWeight.w500, // Medium for titles
        color: Colors.black87,
        letterSpacing: 0,
        height: 1.2,
      ),
      titleMedium: GoogleFonts.poppins( //  titles
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
        letterSpacing: 0.15,
        height: 1.2,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
        letterSpacing: 0.1,
        height: 1.2,
      ),
      bodyLarge: GoogleFonts.lato( // Normal body text
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.black87,
        letterSpacing: 0.15,
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.lato(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.black87,
        letterSpacing: 0.25,
        height: 1.5,
      ),
      bodySmall: GoogleFonts.lato(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Colors.black87,
        letterSpacing: 0.4,
        height: 1.5,
      ),
      labelLarge: GoogleFonts.poppins(  // Button text
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white, // Button text color (light background)
        letterSpacing: 0.1,
        height: 1.2,
      ),
      labelMedium: GoogleFonts.poppins(  // Text for smaller labels
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
        letterSpacing: 0.1,
        height: 1.2,
      ),
      labelSmall: GoogleFonts.poppins(  // Text for Captions and tags
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.grey, // or a secondary color
        letterSpacing: 0.2,
        height: 1.2,
      ),
    );

}



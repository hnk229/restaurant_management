import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFFFF6F61), // Une couleur chaude et appétissante, idéale pour les boutons et les éléments importants.
  onPrimary: Color(0xFF4A4A4A), // Pour les textes et les éléments neutres.
  secondary: Color(0xFF06D6A0 ), // Pour les indicateurs de succès ou les éléments positifs.
  onSecondary: Color(0xFFFFD166 ), // Pour les accents et les éléments interactifs.
  error: Color(0xFFEF476F), // Pour les alertes ou les messages d'erreur.
  onError: Color(0xFF118AB2), // Pour les liens et les informations secondaires.
  surface: Color(0xFFF4F4F4), // Pour les arrière-plans, afin de garder l'interface légère et aérée.
  onSurface: Color(0xFFFFFFFF), // Pour les cartes, les formulaires et les sections de contenu.
);

// const darkColorScheme = ColorScheme(
//   brightness: Brightness.dark,
//   primary: Color(0xFF3e65af),
//   onPrimary: Color(0xFFFFFFFF),
//   secondary: Color(0xFFe9674b),
//   background: Color.fromARGB(255, 41, 38, 38),
//   onSecondary: Color(0xFFFFFFFF),
//   error: Color(0xFFBA1A1A),
//   onError: Color(0xFFFFFFFF),
//   shadow: Color.fromARGB(255, 32, 32, 32),
//   outlineVariant: Color(0xFFC2C8BC),
//   surface: Color(0xFF2caea4),
//   onSurface: Color(0xFF1A1C18),
// );

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    backgroundColor: lightColorScheme.onSurface,
    foregroundColor: lightColorScheme.onPrimary,
    titleTextStyle: TextStyle(
      color: lightColorScheme.onPrimary,
      fontSize: 22,
    ),
    iconTheme: IconThemeData(
      color: lightColorScheme.onPrimary,
    ),
  ),
  popupMenuTheme: PopupMenuThemeData(
    color: lightColorScheme.surface, // Appliquer un thème global
    textStyle:
        TextStyle(color: lightColorScheme.onPrimary), // Couleur du texte globale
  ),
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  textTheme: GoogleFonts.poppinsTextTheme().apply(
    bodyColor: lightColorScheme.onPrimary,
    displayColor: lightColorScheme.onPrimary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(
        lightColorScheme.primary, // Slightly darker shade for the button
      ),
      foregroundColor:
          WidgetStateProperty.all<Color>(lightColorScheme.onSurface), // text color
      elevation: WidgetStateProperty.all<double>(5.0), // shadow
      padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 13)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Adjust as needed
        ),
      ),
    ),
  ),
);

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  // colorScheme: darkColorScheme,
);

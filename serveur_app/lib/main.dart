import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_management/widgets/sideBar.dart';
import 'theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Forcer l'application à rester en mode portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,  // Paysage vers la gauche
    DeviceOrientation.landscapeRight, // Paysage vers la droite
    ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Masquer la bannière de débogage
      title: 'Restaurant Management',
      theme: lightMode,
      home: const SideBar(),
    );
  }
}


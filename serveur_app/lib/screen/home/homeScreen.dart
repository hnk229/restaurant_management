import 'package:flutter/material.dart';
import 'package:restaurant_management/config/widget.dart';
import 'package:restaurant_management/theme/theme.dart';
import '../../config/config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    AppConfig.init(context); // Initialisation de la configuration de l'écran
    return CustomContainer(
      child: Center(
        child: Text(
          'Home Screen',
          style: TextStyle(
            fontSize: titleSize,
            color: lightColorScheme.primary,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/widgets.dart';

class AppConfig {
  static late double screenWidth;
  static late double screenHeight;

  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }
  // static double get titleSize => screenWidth * 0.04;
  // static double get subTitleSize => screenWidth * 0.03;
  // static double get bodyTextSize => screenWidth * 0.02;
  // static double get buttonSize => screenWidth * 0.02;
  // static double get iconSize => screenWidth * 0.03;
  // static double get paddingSize => screenWidth * 0.05;
  // static double get marginSize => screenWidth * 0.05;
  // static double get borderRadius => screenWidth * 0.05;
  // static double get elevation => screenWidth * 0.02;
  // static double get cardWidth => screenWidth * 0.9;
  // static double get cardHeight => screenHeight * 0.3;
  // static double get cardPadding => screenWidth * 0.05;
  // static double get cardMargin => screenWidth * 0.05;
  // static double get cardBorderRadius => screenWidth * 0.05;
  // static double get cardElevation => screenWidth * 0.02;
}

double titleSize = AppConfig.screenWidth * 0.03;
double subTitleSize = AppConfig.screenWidth * 0.025;
double bodyTextSize = AppConfig.screenWidth * 0.015;
double buttonSize = AppConfig.screenWidth * 0.015;
double iconSize = AppConfig.screenWidth * 0.02;
double paddingSize = AppConfig.screenWidth * 0.15;
double marginSize = AppConfig.screenWidth * 0.015;
double borderRadius = AppConfig.screenWidth * 0.007;
double elevation = AppConfig.screenWidth * 0.02;
double cardWidth = AppConfig.screenWidth * 0.2;
double cardHeight = AppConfig.screenHeight * 0.1;
double cardPadding = AppConfig.screenWidth * 0.05;
double cardMargin = AppConfig.screenWidth * 0.05;
double cardBorderRadius = AppConfig.screenWidth * 0.05;
double cardElevation = AppConfig.screenWidth * 0.02;
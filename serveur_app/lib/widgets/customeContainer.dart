import 'package:flutter/material.dart';
import 'package:restaurant_management/theme/theme.dart';

import '../config/config.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  const CustomContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: marginSize,
        right: marginSize,
        bottom: marginSize,
      ),
      decoration: BoxDecoration(
        color: lightColorScheme.onSurface,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );
  }
}
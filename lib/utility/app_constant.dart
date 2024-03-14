import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppConstant {
  //field
  static String appName = 'Ung Book';
  static Color mainColor = const Color.fromARGB(255, 11, 99, 172);

  //method

  BoxDecoration basicBox() => BoxDecoration(color: mainColor.withOpacity(0.85));

  BoxDecoration linearBox() => BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.white, mainColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      );

  BoxDecoration radienBox() => BoxDecoration(
      gradient: RadialGradient(
          colors: [Colors.white, mainColor],
          radius: 1.0,
          center: const Alignment(0, -0.5)));

  BoxDecoration imageBox() => const BoxDecoration(
      image: DecorationImage(
          image: AssetImage('images/bg.jpg'), fit: BoxFit.cover));

  TextStyle h1Style() {
    return const TextStyle(fontSize: 36, fontWeight: FontWeight.bold);
  }

  TextStyle h2Style({double? size}) {
    return TextStyle(fontSize: size ?? 20, fontWeight: FontWeight.w700);
  }

  TextStyle h3Style() {
    return const TextStyle(fontSize: 14, fontWeight: FontWeight.normal);
  }
}

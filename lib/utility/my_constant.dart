import 'package:flutter/material.dart';

class MyConstant {
  static String appName = 'Ung Store';
  static String rountAuthen = '/authen';
  static String rountCreateAccount = '/createAccount';
  static String rountBuyer = '/buyer';
  static String rountSeller = '/seller';
   static String rountAddProduct = '/addProduct';

  static Color primary = const Color(0xff309aa8);
  static Color dark = const Color(0xff00353d);
  static Color light = const Color(0xff69cbda);

  BoxDecoration mainBox() => BoxDecoration(color: primary.withOpacity(0.75));

  TextStyle h1Style() => TextStyle(
        color: dark,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      );

  TextStyle h2Style() => TextStyle(
        color: dark,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      );

  TextStyle h3Style() => TextStyle(
        color: dark,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      );

  TextStyle h3PinkStyle() => const TextStyle(
        color: Colors.pink,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      );
}

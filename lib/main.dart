import 'dart:async';
// ignore: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:gripngrab/landing_page.dart';
import 'package:gripngrab/splash_screen.dart';
import 'package:provider/provider.dart';
import 'auth_provider_page.dart';
import 'login_page.dart';
import 'package:gripngrab/otp.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
providers: [
ChangeNotifierProvider (create: (_) => AuthProvider()),],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      theme: ThemeData(
        primarySwatch:  buildMaterialColor(const Color(0xFFBACBD3)),
       
      ),
      home:  SplashScreen(),
      
    ),);
  }
  
  MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
}


import 'package:app_deteccion_personas/src/pages/home_page.dart';
import 'package:app_deteccion_personas/src/pages/splash_page.dart';
import 'package:flutter/material.dart';

import 'src/pages/login_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home' : ( BuildContext context ) => HomePage(),
        'login' : ( BuildContext context ) => LoginPage(),
        'splash' : ( BuildContext context ) => SplashPage()
      },
    );
  }
}
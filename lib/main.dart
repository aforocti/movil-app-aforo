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
      initialRoute: 'login',
      routes: {
        'home' : ( BuildContext context ) => HomePage(),
        'login' : ( BuildContext context ) => LoginPage(),
        'splash' : ( BuildContext context ) => SplashPage()
      },
      theme: ThemeData(
          primaryColor: Color.fromRGBO(168, 97, 93, 1.0)
        ),
    );
  }
}


// COLORES
// Color.fromRGBO(247, 243, 241, 1.0)
// Color.fromRGBO(239, 218, 213, 1.0)
// Color.fromRGBO(255, 199, 124, 1.0)
// Color.fromRGBO(241, 94, 74, 1.0)
// Color.fromRGBO(168, 97, 93, 1.0)
// Color.fromRGBO(10, 52, 68, 1.0)
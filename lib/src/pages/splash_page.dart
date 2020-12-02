// import 'dart:async';

import 'package:app_deteccion_personas/src/pages/home_page.dart';
import 'package:app_deteccion_personas/src/pages/login_page.dart';
import 'package:app_deteccion_personas/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:app_deteccion_personas/src/utils/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _prefs = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 3,
      navigateAfterSeconds: selectPage(),
      title: new Text(
        'Welcome to Tinkvice',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: Image(
        height: 144.0 + 20.0,
        width: 144.0 + 20.0,
        fit: BoxFit.fill,
        image: AssetImage('assets/ic_splash.png'),
      ),
      backgroundColor: utils.getColor('color2'),
      loaderColor: Colors.red,
    );
  }

  Widget selectPage() {
    if (_prefs.tokenUser == '')
      return LoginPage();
    else
      return HomePage();
  }
}

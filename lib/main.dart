import 'package:app_deteccion_personas/src/blocs/provider.dart';
import 'package:app_deteccion_personas/src/pages/network_page.dart';
import 'package:app_deteccion_personas/src/pages/home_page.dart';
import 'package:app_deteccion_personas/src/pages/register_page.dart';
import 'package:app_deteccion_personas/src/pages/settings_page.dart';
import 'package:app_deteccion_personas/src/pages/splash_page.dart';
import 'package:app_deteccion_personas/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:app_deteccion_personas/src/providers/push_notifications_provider.dart';
import 'package:flutter/material.dart';
import 'src/pages/login_page.dart';
import 'src/preferencias_usuario/preferencias_usuario.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  
  runApp(MyApp());
}

class MyApp extends StatefulWidget with WidgetsBindingObserver{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    final pushProvider = new PushNotificationsProvider();
    pushProvider.initNotifications();
    pushProvider.mensajesStream.listen(( data ) {
      navigatorKey.currentState.pushNamed('home', arguments: data );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Tinkvice',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        initialRoute: 'splash',
        routes: {
          'home'     : (BuildContext context) => HomePage(),
          'login'    : (BuildContext context) => LoginPage(),
          'register' : (BuildContext context) => RegisterPage(),
          'splash'   : (BuildContext context) => SplashPage(),
          'setting'  : (BuildContext context) => SettingPage(),
          'network'  : (BuildContext context) => NetworkPage(),
        },
        theme: ThemeData(primaryColor: Color.fromRGBO(168, 97, 93, 1.0)),
      ),
    );
  }
}
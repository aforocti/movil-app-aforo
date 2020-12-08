import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del _colorSecundario
  get colorSecundario {
    return _prefs.getBool('colorSecundario') ?? false;
  }

  set colorSecundario( bool value ) {
    _prefs.setBool('colorSecundario', value);
  }

  // // GET y SET del _tokenUser
  // get tokenUser {
  //   return _prefs.getString('tokenUser') ?? '';
  // }

  // set tokenUser( String value ) {
  //   _prefs.setString('tokenUser', value);
  // }

  // GET y SET del _fcmToken
   get fcmToken {
    return _prefs.getString('FCMToken') ?? '';
  }

  set fcmToken( String value ) {
    _prefs.setString('FCMToken', value);
  }

  // GET y SET del _tokenNetwork
   get tokenNetwork {
    return _prefs.getString('tokenNetwork') ?? '';
  }

  set tokenNetwork( String value ) {
    _prefs.setString('tokenNetwork', value);
  }
  
  // GET y SET del _nameNetwork
   get nombreNetwork {
    return _prefs.getString('nombreNetwork') ?? '';
  }

  set nombreNetwork( String value ) {
    _prefs.setString('nombreNetwork', value);
  }

  // GET y SET del nombreUsuario
  get nombreUsuario {
    return _prefs.getString('nombreUsuario') ?? '';
  }

  set nombreUsuario( String value ) {
    _prefs.setString('nombreUsuario', value);
  }

  //   // GET y SET de la última página
  // get ultimaPagina {
  //   return _prefs.getString('ultimaPagina') ?? 'home';
  // }

  // set ultimaPagina( String value ) {
  //   _prefs.setString('ultimaPagina', value);
  // }

}



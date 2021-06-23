import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthProvider {

  // clave de API web (_firebaseToken)
  final String _firebaseToken = 'AIzaSyB6zcZjbacTzXQuO6ekORN0Z6A3QfHt26c';

  Future<Map<String, dynamic>> login( String email, String password) async {

    final authData = {
      'email'   : email,
      'password': password,
      'returnSecureToken' : true,
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
      body: json.encode( authData )
    );

    Map<String,dynamic> decodedResp = json.decode( resp.body );

    print(decodedResp);

    if ( decodedResp.containsKey('idToken') ) {
      return { 'ok' : true, 'token' : decodedResp['idToken'] };
    } else {
      return { 'ok' : false, 'mensaje' : decodedResp['error']['message']  };
    }

  }

  Future<Map<String, dynamic>> nuevoUsuario( String email, String password ) async {

    final authData = {
      'email'   : email,
      'password': password,
      'returnSecureToken' : true
    };

    print(authData);

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
      body: json.encode( authData )
    );

    Map<String,dynamic> decodedResp = json.decode( resp.body );

    print(decodedResp);

    if ( decodedResp.containsKey('idToken') ) {
      return { 'ok' : true, 'token' : decodedResp['idToken'] };
    } else {
      return { 'ok' : false, 'mensaje' : decodedResp['error']['message']  };
    }
  }
}
import 'package:app_deteccion_personas/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:flutter/material.dart';


final prefs = PreferenciasUsuario();

mostrarAlerta(BuildContext context, {String title, String content}) {
  
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(cambiarTexto(content)),
        actions: <Widget>[
          FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Ok',
                  style: TextStyle(color: Color.fromRGBO(10, 52, 68, 1.0))))
        ],
      );
    }
  );

}

String cambiarTexto(String texto) {

  Map<String, String> mapa = {
    'MISSING_EMAIL'    : 'FALTA EL CORREO ELECTRÓNICO',
    'INVALID_EMAIL'    : 'CORREO ELECTRÓNICO INCORRECTO',
    'INVALID_PASSWORD' : 'CONTRASEÑA INCORRECTA',
    'EMAIL_NOT_FOUND'  : 'CORREO NO ENCONTRADO',
    'MISSING_PASSWORD' : 'FALTA LA CONTRASEÑA',
    'EMAIL_EXISTS'     : 'EL CORREO YA EXISTE',
  };
  if (mapa.containsKey(texto)) return mapa[texto];
  return texto;

}

Color getColor(String color) {

  Map<String, Color> mapa = {
    'color1'     : Color.fromRGBO(247, 243, 241, 1.0),
    'color2'     : Color.fromRGBO(239, 218, 213, 1.0),
    'color2t1'   : Color.fromRGBO(225, 207, 202, 1.0),
    'color3'     : Color.fromRGBO(255, 199, 124, 1.0),
    'color3t1'   : Color.fromRGBO(255, 200, 144, 1.0),
    'color4'     : Color.fromRGBO(241, 94, 74, 1.0),
    'color4t4'   : Color.fromRGBO(248, 175, 165, 1.0), // tinte 4 de color4
    'color4t4t1' : Color.fromRGBO(233, 169, 160, 1.0), // tinte 1 de color4t4
    'color5'     : Color.fromRGBO(168, 97, 93, 1.0),
    'color6'     : Color.fromRGBO(10, 52, 68, 1.0),
    'color6t5'   : Color.fromRGBO(83, 99, 105, 1.0),  // tono 5 de color6
  };
  if (mapa.containsKey(color)) return mapa[color];
  return mapa['color1'];

}

Color setColor(String secundario, String primario) {
  return (prefs.colorSecundario) ? getColor(secundario) : getColor(primario);
}
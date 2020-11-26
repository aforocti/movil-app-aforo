import 'dart:ui';

import 'package:flutter/material.dart';

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
  });
}

String cambiarTexto(String texto) {
  Map<String, String> mapa = {
    "MISSING_EMAIL"   : "FALTA EL CORREO ELECTRÓNICO",
    "INVALID_EMAIL"   : "CORREO ELECTRÓNICO INCORRECTO",
    "MISSING_PASSWORD": "FALTA LA CONTRASEÑA",
  };

  if (mapa.containsKey(texto)) return mapa[texto];

  return texto;
}

import 'dart:ui';

import 'package:flutter/material.dart';
import '../preferencias_usuario/preferencias_usuario.dart';
import '../utils/utils.dart' as utils;

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final infoToken =
      'Usa este token en tu script en network_id antes de ejecutarlo para que puedas enviar la información de tu empresa a la base de datos de Firestore';
  bool _colorSecundario;

  final _prefs = PreferenciasUsuario();

  @override
  void initState() {
    super.initState();
    _colorSecundario = _prefs.colorSecundario;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: utils.setColor('color1', 'color6'),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'home');
                  setState(() {});
                }),
            title: Text('Ajustes',
                style: TextStyle(color: utils.setColor('color1', 'color6'))),
            centerTitle: true,
            backgroundColor: utils.setColor('color6', 'color2')),
        body: ListView(
          children: [
            subtitulo('Configuraciones'),
            Divider(),
            makeSwitchListTile(),
            Divider(),
            subtitulo('Token'),
            texto(infoToken),
            fcmToken(),
            Divider(),
            flatButton(context)
          ],
        ),
      ),
    );
  }

  Widget subtitulo(String subtitulo) {
    return Container(
      padding: EdgeInsets.only(top: 15, left: 10),
      child: Text(subtitulo,
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
    );
  }

  makeSwitchListTile() {
    return SwitchListTile(
        activeColor: utils.getColor('color6'),
        value: _colorSecundario,
        title: Text('Color secundario'),
        onChanged: (value) {
          setState(() {
            _colorSecundario = value;
            _prefs.colorSecundario = value;
          });
        });
  }

  Widget flatButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
      child: FlatButton(
        child: Text('Cerrar Sesión',
            style: TextStyle(color: utils.getColor('color1'))),
        color: utils.setColor('color6t5', 'color5'),
        onPressed: () => _cerrarSesion(context),
      ),
    );
  }

  _cerrarSesion(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Cerrar Sesión'),
            content: Text('Deseas cerrar la sesión'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    _prefs.tokenUser = '';
                    Navigator.pushReplacementNamed(context, 'splash');
                  },
                  child: Text('Ok',
                      style: TextStyle(color: Color.fromRGBO(10, 52, 68, 1.0))))
            ],
          );
        });
  }

  Widget fcmToken() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
          height: 40.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(width: 2.0, color: Colors.black12),
              color: Colors.black12),
          child: Center(
            child: Text('uGs729maxjnVVrpz63Vn', style: TextStyle(fontSize: 20)),
          )),
    );
  }

  Widget texto(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(text, style: TextStyle(color: Colors.grey)),
    );
  }
}

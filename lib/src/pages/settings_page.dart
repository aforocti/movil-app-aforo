
import 'package:flutter/material.dart';
import 'package:app_deteccion_personas/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:app_deteccion_personas/src/utils/utils.dart' as utils;

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _colorSecundario;
  final _prefs = PreferenciasUsuario();
  final _infoToken =
      'Úsalo en tu script para enviar la información de la red a la base de datos';

  @override
  void initState() {
    super.initState();
    _colorSecundario = _prefs.colorSecundario;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: utils.getColor('color1'),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'home');
            setState(() {});
          },
          icon: Icon(Icons.arrow_back_ios),
          color: utils.setColor('color1', 'color6')
        ),
        title: Text('Ajustes',
            style: TextStyle(color: utils.setColor('color1', 'color6'))),
        centerTitle: true,
        backgroundColor: utils.setColor('color6', 'color2')
      ),
      body: ListView(
        children: [
          _subtitulo('Información'),
          _listtile(title: 'Usuario', trailing: _prefs.nombreUsuario),
          _listtile(title: 'Nombre de red', trailing: _prefs.nombreNetwork),
          _listtile(title: 'Token', trailing: _prefs.tokenNetwork, subtitle: _infoToken),
          _subtitulo('Ajustes adicionales'),
          _swtichListTile(),
          _flatButton(context),
        ],
      ),
    ));
  }

  Widget _listtile({String title, String trailing, String subtitle = ''}) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(width: 0.1, color: Colors.grey)),
      child: ListTile(
        title: Text(title),
        subtitle: (subtitle != '') ? Text(subtitle) : null,
        trailing: Text(trailing, style: TextStyle(fontWeight: FontWeight.w300)),
        tileColor: Colors.white
      ),
    );
  }

  Widget _subtitulo(String subtitulo) {
    return Container(
      padding: EdgeInsets.only(top: 15, left: 15, bottom: 10),
      child: Text(subtitulo,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget _swtichListTile() {
    return Container(
      decoration: BoxDecoration( color: Colors.white,
        border: Border.all(width: 0.1, color: Colors.grey)
      ),
      child: SwitchListTile(
        activeColor: utils.getColor('color6'),
        title: Text('Color secundario'),
        value: _colorSecundario,
        onChanged: (value) {
          setState(() {
            _colorSecundario = value;
            _prefs.colorSecundario = value;
          });
        }
      ),
    );
  }

  Widget _flatButton(BuildContext context) {
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
    showDialog( context: context, builder: (context) {
      return AlertDialog(
        title: Text('Cerrar Sesión'),
        content: Text('¿Deseas cerrar la sesión?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              // _prefs.tokenUser = '';
              _prefs.tokenNetwork = '';
              _prefs.nombreNetwork = '';
              _prefs.nombreUsuario = '';
              Navigator.pushReplacementNamed(context, 'splash');
            },
            child: Text('Ok',
                style: TextStyle(color: Color.fromRGBO(10, 52, 68, 1.0)))
          )
        ],
      );
    });
  }
}

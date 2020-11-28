
import 'package:flutter/material.dart';
import '../preferencias_usuario/preferencias_usuario.dart';
import '../utils/utils.dart' as u;

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  bool _colorSecundario;

  final prefs = PreferenciasUsuario();

  @override
  void initState() { 
    super.initState();
    _colorSecundario = prefs.colorSecundario;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ajustes',
            style: TextStyle(color: (prefs.colorSecundario) ? u.getColor('color1') : u.getColor('color6'))
          ),
          centerTitle: true,
          backgroundColor: (prefs.colorSecundario) ? u.getColor('color6') : u.getColor('color2')
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(5.0),
              child: Text('Configuraciones',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            ),
            Divider(),
            SwitchListTile(
              activeColor: u.getColor('color6'),
              value: _colorSecundario,
              title: Text('Color secundario'),
              onChanged: ( value ) {
                setState(() {
                  _colorSecundario = value;
                  prefs.colorSecundario = value;
                });
              }
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: FlatButton(
                child: Text('Regresar',
                  style: TextStyle(color: (prefs.colorSecundario) ? u.getColor('color1') : u.getColor('color1'))
                ),
                color: (prefs.colorSecundario) ? u.getColor('color6t5') : u.getColor('color5'),
                onPressed: () => Navigator.pushReplacementNamed(context, 'home'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
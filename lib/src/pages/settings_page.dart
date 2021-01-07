import 'dart:io';

import 'package:app_deteccion_personas/src/providers/image_provider.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:app_deteccion_personas/src/providers/device_provider.dart';
import 'package:app_deteccion_personas/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:app_deteccion_personas/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _colorSecundario;
  File _image;
  int _piso = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final deviceProvicer = DeviceProvider();
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
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: utils.getColor('color1'),
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'home');
                setState(() {});
              },
              icon: Icon(Icons.arrow_back_ios),
              color: utils.setColor('color1', 'color6')),
          title: Text('Información y ajustes',
              style: TextStyle(color: utils.setColor('color1', 'color6'))),
          centerTitle: true,
          backgroundColor: utils.setColor('color6', 'color2')),
      body: Builder(
        builder: (context) => ListView(
          children: [
            _subtitulo('Información'),
            _listtile(title: 'Usuario', trailing: _prefs.nombreUsuario),
            _listtile(title: 'Nombre de red', trailing: _prefs.nombreNetwork),
            _listtile(
                title: 'Token',
                trailing: _prefs.tokenNetwork,
                subtitle: _infoToken),
            _subtitulo('Ajustes'),
            _swtichListTile(),
            _cargarImagen(),
            _flatButton(context),
          ],
        ),
      ),
    );
  }

  Widget _listtile({String title, String trailing, String subtitle = ''}) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(width: 0.1, color: Colors.grey)),
      child: ListTile(
          title: Text(title),
          subtitle: (subtitle != '') ? Text(subtitle) : null,
          trailing:
              Text(trailing, style: TextStyle(fontWeight: FontWeight.w300)),
          tileColor: Colors.white),
    );
  }

  Widget _subtitulo(String subtitulo) {
    return Container(
      padding: EdgeInsets.only(top: 15, left: 15, bottom: 10),
      child: Text(subtitulo,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _swtichListTile() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.1, color: Colors.grey)),
      child: ListTile(
        leading: Icon(Icons.color_lens),
        title: Text('Color secundario'),
        trailing: Switch(
            activeColor: utils.getColor('color6'),
            value: _colorSecundario,
            onChanged: (value) {
              setState(() {
                _colorSecundario = value;
                _prefs.colorSecundario = value;
              });
            }),
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
          onPressed: () async {
            final connectivityResult =
                await (Connectivity().checkConnectivity());
            if (connectivityResult == ConnectivityResult.none) {
              utils.snackBarMessage(context, "Sin conexion");
            } else {
              _prefs.tokenNetwork = '';
              _prefs.nombreNetwork = '';
              _prefs.nombreUsuario = '';
              deviceProvicer.eliminarDevice(_prefs.fcmToken);
              Navigator.pushReplacementNamed(context, 'splash');
            }
          }),
    );
  }

  Widget _cargarImagen() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.1, color: Colors.black87)),
      padding: EdgeInsets.only(bottom: 10.0),
      child: Column(
        children: [
          ListTile(
            title: Text('Cargar Mapa'),
            leading: Icon(Icons.image),
            tileColor: Colors.white,
            onTap: _seleccionarFoto,
          ),
          mostrarFoto(),
        ],
      ),
    );
  }

  void _seleccionarFoto() async {
    final picker = ImagePicker();
    try {
      PickedFile pickedFile =
          await picker.getImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile == null) {
          print('No image selected.');
        } else {
          _image = File(pickedFile.path);
        }
      });
    } catch (e) {
      print('Acceso denegado');
    }
  }

  Widget mostrarFoto() {
    if (_image?.path != null) {
      return Column(
        children: [
          Image(
            image: AssetImage(_image?.path ?? 'assets/no-image.png'),
            height: 200,
            fit: BoxFit.cover,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            FlatButton(
                splashColor: Colors.white,
                onPressed: () {
                  if (_piso != 0) _piso = (_piso - 1);
                  setState(() {});
                },
                child: Icon(Icons.arrow_back)),
            Container(
              child: Text((_piso.toString() == '0') ? 'PB' : '$_piso P'),
            ),
            FlatButton(
                splashColor: Colors.white,
                onPressed: () {
                  _piso = (_piso + 1);
                  setState(() {});
                },
                child: Icon(Icons.arrow_forward)),
          ]),
          FlatButton(
            color: utils.setColor('color6t5', 'color5'),
            child: Text('Cargar',
                style: TextStyle(color: utils.getColor('color1'))),
            onPressed: () async {
              final imageProvider = new ImagenProvider();
              final url = await imageProvider.subirImagen(_image, _piso.toString());
              print(url);
            },
          )
        ],
      );
    }
    return Container();
  }
}

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:app_deteccion_personas/src/utils/utils.dart' as utils;
import 'package:app_deteccion_personas/src/providers/image_provider.dart';

class UploadMapPage extends StatefulWidget {
  @override
  _UploadMapPageState createState() => _UploadMapPageState();
}

class _UploadMapPageState extends State<UploadMapPage> {
  File _image;
  int _piso = 0;
  bool _enableFAB = false;
  String url = 'assets/no-image.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Cargar Plano'),
        backgroundColor:
            (!_enableFAB) ? Colors.grey : utils.setColor('color6', 'color5'),
        icon: Icon(Icons.upload_file),
        onPressed: (!_enableFAB)
            ? null
            : () async {
                final imageProvider = new ImagenProvider();
                String pisoExist =
                    await imageProvider.cargarImageByPiso(_piso.toString());
                  await imageProvider.subirImagen(_image, _piso.toString(), pisoExist);
                Navigator.pushReplacementNamed(context, 'home');
              },
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _seleccionarFoto,
            icon: Icon(Icons.image),
          )
        ],
        backgroundColor: utils.setColor('color6', 'color5'),
        title: Text('Cargar Plano'),
      ),
      body: Stack(
        children: [
          mostrarFoto(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                textColor: Colors.white,
                padding: EdgeInsets.all(12.0),
                shape: CircleBorder(),
                color: utils.setColor('color6t5', 'color5'),
                splashColor: Colors.white,
                onPressed: () {
                  if (_piso != 0) _piso = (_piso - 1);
                  setState(() {});
                },
                child: Icon(Icons.arrow_back),
              ),
              Container(
                margin: EdgeInsets.all(5.0),
                padding: EdgeInsets.all(12.0),
                color: utils.setColor('color6t5', 'color5'),
                child: Text(
                  (_piso.toString() == '0') ? 'PB' : '${_piso}P',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              FlatButton(
                textColor: Colors.white,
                padding: EdgeInsets.all(12.0),
                shape: CircleBorder(),
                color: utils.setColor('color6t5', 'color5'),
                splashColor: Colors.white,
                onPressed: () {
                  setState(() => _piso = (_piso + 1));
                },
                child: Icon(Icons.arrow_forward),
              ),
            ],
          ),
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
          _enableFAB = true;
        }
        url = _image.path;
      });
    } catch (e) {
      print('Acceso denegado');
    }
  }

  Widget mostrarFoto(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: (_image?.path != null)
            ? Image(image: AssetImage(url), fit: BoxFit.cover)
            : utils.iconFont(Icons.image, context,
                'Selecciona el ícono en la esquina superior derecha para cargar un plano desde la galería. No olvides seleccionar el piso'));
  }
}

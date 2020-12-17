import 'dart:ui';

import 'package:app_deteccion_personas/src/models/network_model.dart';
import 'package:app_deteccion_personas/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:app_deteccion_personas/src/providers/device_provider.dart';
import 'package:app_deteccion_personas/src/providers/network_provider.dart';
import 'package:app_deteccion_personas/src/providers/user_provider.dart';
import 'package:app_deteccion_personas/src/utils/utils.dart' as utils;
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class NetworkPage extends StatefulWidget {
  @override
  _NetworkPageState createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  final networkProvider = new NetworkProvider();
  final userProvider = new UserProvider();
  final deviceProvider = new DeviceProvider();
  final _prefs = PreferenciasUsuario();
  String _nombreNetwork = '';
  String _nombreToken = '';
  bool _isButtonEnable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: utils.getColor('color2'),
        body: Builder(builder: (context) => Center(child: _form(context))));
  }

  Widget _form(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        width: size.width * 0.85,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        decoration: BoxDecoration(
            color: Color.fromRGBO(247, 243, 241, 1.0),
            borderRadius: BorderRadius.circular(7.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0)
            ]),
        child: Column(
          children: [
            _returnButton(),
            SizedBox(height: 20.0),
            _texto(
                'Si ya cuentas con un token, ingrésalo para acceder a la red'),
            SizedBox(height: 10.0),
            _inputNetworkToken(),
            Row(children: [
              Expanded(child: Container()),
              _tokenButton(context),
            ]),
            SizedBox(height: 20.0),
            _texto(
                'Si aún no tienes un token de red asociado, Ingresa un nombre para tu nueva red'),
            SizedBox(height: 10.0),
            _inputNetworkName(),
            Row(children: [
              Expanded(child: Container()),
              _networkButton(context),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _inputNetworkToken() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1.0),
        color: Colors.white,
      ),
      child: TextField(
        textAlign: TextAlign.center,
        onChanged: (value) => setState(() {
          _nombreToken = value;
        }),
        style: TextStyle(fontSize: 20.0),
        autofocus: false,
      ),
    );
  }

  Widget _inputNetworkName() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1.0),
        color: Colors.white,
      ),
      child: TextField(
        textAlign: TextAlign.center,
        onChanged: (value) => setState(() {
          _nombreNetwork = value;
        }),
        style: TextStyle(fontSize: 20.0),
        autofocus: false,
      ),
    );
  }

  Widget _texto(String texto) {
    return Text(texto, style: TextStyle(fontWeight: FontWeight.bold));
  }

  Widget _tokenButton(BuildContext context) {
    return RaisedButton(
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Text('Acceder')),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      color: Color.fromRGBO(138, 67, 63, 1.0),
      textColor: Colors.white,
      onPressed: (_isButtonEnable) ? () => _tokenButtonAction(context) : null,
    );
  }

  _tokenButtonAction(context) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      utils.snackBarMessage(context, "Sin conexion");
    } else {
      setState(() => _isButtonEnable = false);
      try {
        final networkName =
            await networkProvider.obtenerNetworkByToken(_nombreToken);
        if (networkName == null) {
          Future.delayed(Duration(seconds: 1), () {}).then((value) =>
              setState(() => _isButtonEnable = true));
          utils.snackBarMessage(context, "El token ingresado no existe");
        } else {
          Future.delayed(Duration(seconds: 3), () {}).then((value) =>
              setState(() => _isButtonEnable = true));
          await userProvider.crearUser(_prefs.nombreUsuario, _nombreToken);
          await deviceProvider.crearDevice(_nombreToken, _prefs.fcmToken);
          _prefs.nombreNetwork = networkName;
          _prefs.tokenNetwork = _nombreToken;
          Navigator.pushReplacementNamed(context, 'home');
        }
      } catch (e) {
        Future.delayed(Duration(seconds: 1), () {}).then((value) =>
            setState(() => _isButtonEnable = true));
        _prefs.nombreNetwork = '';
        _prefs.tokenNetwork = '';
        utils.mostrarAlerta(context,
            title: 'Error', content: 'Error inesperado');
      }
    }
  }

  Widget _networkButton(BuildContext context) {
    return RaisedButton(
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Text('Crear')),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      color: Color.fromRGBO(138, 67, 63, 1.0),
      textColor: Colors.white,
      onPressed: (_isButtonEnable) ? () => _networkButtonAction(context) : null,
    );
  }

  _networkButtonAction(BuildContext context) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      utils.snackBarMessage(context, "Sin conexion");
    } else {
      setState(() => _isButtonEnable = false);
      try {
        Future.delayed(Duration(seconds: 2), () {}).then((value) =>
              setState(() => _isButtonEnable = true));
        NetworkModel network =
            await networkProvider.crearNetwork(_nombreNetwork);
        _prefs.tokenNetwork = network.id;
        _prefs.nombreNetwork = network.name;
        await userProvider.crearUser(
            _prefs.nombreUsuario, _prefs.tokenNetwork);
        await deviceProvider.crearDevice(network.id, _prefs.fcmToken);
        Navigator.pushReplacementNamed(context, 'home');
      } catch (e) {
        Future.delayed(Duration(seconds: 1), () {}).then((value) =>
            setState(() => _isButtonEnable = true));
        _prefs.nombreNetwork = '';
        _prefs.tokenNetwork = '';
        utils.mostrarAlerta(context,
            title: 'Error', content: 'Error inesperado');
      }
    }
  }

  _returnButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.arrow_left, size: 20.0),
        InkWell(
          child: Text('Cerrar Sesión', style: TextStyle(fontSize: 18.0)),
          onTap: (_isButtonEnable) ? () {
            _prefs.nombreUsuario = '';
            Navigator.pushReplacementNamed(context, 'login');
          } : null
        ),
      ],
    );
  }
}

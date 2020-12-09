import 'package:app_deteccion_personas/src/models/network_model.dart';
import 'package:app_deteccion_personas/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:app_deteccion_personas/src/providers/device_provider.dart';
import 'package:app_deteccion_personas/src/providers/network_provider.dart';
import 'package:app_deteccion_personas/src/providers/user_provider.dart';
import 'package:app_deteccion_personas/src/utils/utils.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColor('color2'),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _texto(
                  'Si ya cuentas con un token, ingrésalo para acceder a la red'),
              SizedBox(height: 20.0),
              _inputNetworkToken(),
              Row(children: [
                Expanded(child: Container()),
                _tokenButton(context),
              ]),
              SizedBox(height: 40.0),
              _texto(
                  'Si aún no tienes un token de red asociado, Ingresa un nombre para tu nueva red'),
              SizedBox(height: 20.0),
              _inputNetworkName(),
              Row(children: [
                Expanded(child: Container()),
                _networkButton(context),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputNetworkToken() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: TextField(
        onChanged: (value) => setState(() {
          _nombreToken = value;
        }),
        style: TextStyle(fontSize: 25.0),
        autofocus: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget _inputNetworkName() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: TextField(
        onChanged: (value) => setState(() {
          _nombreNetwork = value;
        }),
        style: TextStyle(fontSize: 25.0),
        autofocus: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget _texto(String texto) {
    return Text(texto,
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold));
  }

  Widget _tokenButton(BuildContext context) {
    return RaisedButton(
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Text('Acceder')),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      color: Color.fromRGBO(138, 67, 63, 1.0),
      textColor: Colors.white,
      onPressed: () async {
        final networkName =
            await networkProvider.obtenerNetworkByToken(_nombreToken);
          await userProvider.crearUser(_prefs.nombreUsuario, _nombreToken);
          await deviceProvider.crearDevice(_nombreToken, _prefs.fcmToken);
          _prefs.nombreNetwork = networkName;
          _prefs.tokenNetwork = _nombreToken;
          Navigator.pushReplacementNamed(context, 'home');
      },
    );
  }

  Widget _networkButton(BuildContext context) {
    return RaisedButton(
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Text('Crear')),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      color: Color.fromRGBO(138, 67, 63, 1.0),
      textColor: Colors.white,
      onPressed: () async {
        NetworkModel network =
            await networkProvider.crearNetwork(_nombreNetwork);
        _prefs.tokenNetwork = network.id;
        _prefs.nombreNetwork = network.name;
        await userProvider.crearUser(_prefs.nombreUsuario, _prefs.tokenNetwork);
        await deviceProvider.crearDevice(network.id, _prefs.fcmToken);
        Navigator.pushReplacementNamed(context, 'home');
      },
    );
  }
}

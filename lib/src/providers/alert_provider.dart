
import 'dart:convert';
import 'package:app_deteccion_personas/src/models/alert_model.dart';
import 'package:app_deteccion_personas/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class AlertProvider {

  final _prefs = PreferenciasUsuario();
 
  AlertProvider();

  final String _url =
      'https://us-central1-backendapptinkvice.cloudfunctions.net/app';

  Future<List<AlertModel>> cargarAlerts() async {
    final url = '$_url/api/network/${_prefs.tokenNetwork}/alerts';
    final resp = await http.get(url);
    final List<dynamic> decodedData = json.decode(resp.body);
    final alerts = new Alerts.fromJsonList(decodedData);
    return alerts.items;
  }
}

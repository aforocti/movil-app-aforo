import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:app_deteccion_personas/models/alert_model.dart';
import 'package:app_deteccion_personas/preferencias_usuario/preferencias_usuario.dart';
import 'api_url.dart';

class AlertProvider {

  final _prefs = PreferenciasUsuario();

  AlertProvider();

  final _url = ApiUrl().getUrl();

  /// Carga las alertas desde la base de datos.
  Future<dynamic> cargarAlerts() async {
    final url = '$_url/api/network/${_prefs.tokenNetwork}/alerts';
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      await Future.delayed(Duration(milliseconds: 500)); // for animation
      return Future.error('Sin conexion');
    } else {
      final resp = await http.get(url);
      final List<dynamic> decodedData = json.decode(resp.body);
      final alerts = new Alerts.fromJsonList(decodedData).items;
      DateFormat format = DateFormat("dd/MM/yyyy H:m:s");
      print(alerts[0].date + " " + alerts[0].hour);
      alerts.sort((a, b) => (format.parse(b.date + " " + b.hour)).compareTo(format.parse(a.date + " " + a.hour)));
      return alerts;
    }
  }
}

//ap_provider
import 'dart:convert';
import 'package:app_deteccion_personas/src/models/ap_model.dart';
import 'package:app_deteccion_personas/src/models/wlc_model.dart';
import 'package:app_deteccion_personas/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class ApProvider {
  final _prefs = PreferenciasUsuario();

  final String _url =
      'https://us-central1-backendapptinkvice.cloudfunctions.net/app';

  Future<List<ApModel>> cargarAps(String wlcId) async {
    final url = '$_url/api/wlc/$wlcId/aps';
    final resp = await http.get(url);
    final List<dynamic> decodedData = json.decode(resp.body);
    final aps = new Aps.fromJsonList(decodedData);
    return aps.items;
  }

  Future<List<dynamic>> cargarWlcsAps() async {
    final url = '$_url/api/network/${_prefs.tokenNetwork}/wlcs';
    final resp = await http.get(url);
    final List<dynamic> decodedData = json.decode(resp.body);
    final wlcs = new Wlcs.fromJsonList(decodedData);
    List<WlcModel> lista = wlcs.items;
    for (WlcModel item in lista) {
      final url = '$_url/api/wlc/${item.mac}/aps';
      final resp = await http.get(url);
      final List<dynamic> decodedData = json.decode(resp.body);
      final aps = new Aps.fromJsonList(decodedData).items;
      item.aps = aps;
    }
    return wlcs.items;
  }
}

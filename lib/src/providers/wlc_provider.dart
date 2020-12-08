
import 'dart:convert';
import 'package:app_deteccion_personas/src/models/wlc_model.dart';
import 'package:http/http.dart' as http;

class WlcProvider {
 
  WlcProvider();

  final String _url =
      'https://us-central1-backendapptinkvice.cloudfunctions.net/app';

  Future<List<WlcModel>> cargarWlcs() async {
    final url = '$_url/api/network/l5EI9y6nSKQdTbPJtGWf/wlcs';
    final resp = await http.get(url);
    final List<dynamic> decodedData = json.decode(resp.body);
    final wlcs = new Wlcs.fromJsonList(decodedData);
    return wlcs.items;
  }
}

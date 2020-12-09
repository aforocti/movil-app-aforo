import 'dart:convert';
import 'package:app_deteccion_personas/src/models/network_model.dart';
import 'package:http/http.dart' as http;

class NetworkProvider {
  NetworkProvider();

  final String _url =
      'https://us-central1-backendapptinkvice.cloudfunctions.net/app';

  Future<NetworkModel> crearNetwork(String name) async {
    final url = '$_url/api/networks';
    final resp = await http.post(url, body: {"name": name});
    final decodedData = json.decode(resp.body);
    return NetworkModel.fromJson(decodedData);
  }

  Future<String> obtenerNetworkByToken(String token) async {
    final url = '$_url/api/networks/$token';
    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    return decodedData['name'];
  }

}

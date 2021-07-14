import 'dart:convert';
import 'dart:io';
import 'package:app_deteccion_personas/models/network_model.dart';
import 'package:http/http.dart' as http;
import 'api_url.dart';

class NetworkProvider {
  NetworkProvider();

  final String _url = ApiUrl().getUrl();

  Future<NetworkModel> crearNetwork(String name, String capacidad) async {
    final url = '$_url/api/networks';
    final body = json.encode({'name':name,'capacity':capacidad});
    Map<String,String> headers = {
      'Content-type':'application/json',
      'Accept':'application/json'
    };
    final resp = await http.post(url,
        headers:headers,
        body:body);
    final decodedData = json.decode(resp.body);
    return NetworkModel.fromJson(decodedData);
  }

  Future<String> obtenerNetworkByToken(String token) async {
    final url = '$_url/api/networks/$token';
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final Map<String, dynamic> decodedData = json.decode(resp.body);
      return decodedData['data']['name'];
    } else {
      return null;
    }
  }
}

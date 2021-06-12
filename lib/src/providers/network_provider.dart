import 'dart:convert';
import 'dart:io';
import 'package:app_deteccion_personas/src/models/network_model.dart';
import 'package:http/http.dart' as http;

class NetworkProvider {
  NetworkProvider();

  final String _url =
      'https://appaforo.loca.lt';

  Future<NetworkModel> crearNetwork(String name) async {
    final url = '$_url/api/networks';
    final body = json.encode({'name':name});
    Map<String,String> headers = {
      'Content-type':'application/json',
      'Accept':'application/json'
    };
    final resp = await http.post(url,
        headers:headers,
        body:body);
    print(resp);
    print(resp.statusCode);
    final decodedData = json.decode(resp.body);
    return NetworkModel.fromJson(decodedData);
  }

  Future<String> obtenerNetworkByToken(String token) async {
    final url = '$_url/api/networks/$token';
    final resp = await http.get(url);
    print(resp.statusCode);
    if (resp.statusCode == 200) {
      final Map<String, dynamic> decodedData = json.decode(resp.body);
      return decodedData['data']['name'];
    } else {
      return null;
    }
  }
}

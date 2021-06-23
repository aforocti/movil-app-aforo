import 'dart:convert';

import 'package:http/http.dart' as http;
import 'api_url.dart';

class DeviceProvider {
  
  DeviceProvider();

  final String _url = ApiUrl().getUrl();

  Future<bool> crearDevice(String network, String token) async {
    final url = '$_url/api/devices';
    final body = json.encode({"network_id": network, "device_token": token});
    Map<String,String> headers = {
      'Content-type':'application/json',
      'Accept':'application/json'
    };
    await http
        .post(url,
        headers: headers,
        body: body);
    return true;
  }

  Future<bool> eliminarDevice(String token) async {
    final url = '$_url/api/devices/$token';
    await http.delete(url);
    return true;
  }
}

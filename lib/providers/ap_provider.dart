import 'dart:convert';
import 'package:app_deteccion_personas/models/ap_model.dart';
import 'package:app_deteccion_personas/models/wlc_model.dart';
import 'package:app_deteccion_personas/preferencias_usuario/preferencias_usuario.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'api_url.dart';

class ApProvider {
  final _prefs = PreferenciasUsuario();

  final String _url = ApiUrl().getUrl();

  Future<List<ApModel>> cargarAps(String wlcId) async {
    final url = '$_url/api/wlc/$wlcId/aps';
    final resp = await http.get(url);
    final List<dynamic> decodedData = json.decode(resp.body);
    final aps = new Aps.fromJsonList(decodedData);
    return aps.items;
  }

  Future<List<ApModel>> cargarApsByNetwork(String networkId) async {
    final url = '$_url/api/network/$networkId/aps';
    final resp = await http.get(url);
    final List<dynamic> decodedData = json.decode(resp.body);
    final aps = new Aps.fromJsonList(decodedData);
    return aps.items;
  }

  Future<List<dynamic>> cargarWlcsAps() async {
    final url = '$_url/api/network/${_prefs.tokenNetwork}/wlcs';
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      await Future.delayed(Duration(milliseconds: 500)); // for animation
      return Future.error('Sin conexion');
    } else {
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

  Future<bool> actualizarPisoLimite(
      String mac, String limite, String piso) async {
    print(mac);
    print(limite);
    print(piso);
    final body = json.encode({"limit": limite, "piso": piso});
    Map<String,String> headers = {
      'Content-type':'application/json',
      'Accept':'application/json'
    };
    final url = '$_url/api/aps/$mac/limit/piso';
    await http.put(url, body: body,headers: headers);
    return true;
  }

  Future<bool> actualizarDxDy(String mac, String dx, String dy) async {
    final body = json.encode({"dx": dx, "dy": dy});
    Map<String,String> headers = {
      'Content-type':'application/json',
      'Accept':'application/json'
    };
    final url = '$_url/api/aps/$mac/dxdy';
    await http.put(url, body: body,headers: headers);
    return true;
  }
}

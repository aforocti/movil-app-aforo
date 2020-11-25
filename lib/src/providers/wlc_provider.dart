//wlc_provider
import 'dart:convert';
import 'package:app_deteccion_personas/src/models/wlc_model.dart';
import 'package:http/http.dart' as http;


class WlcProvider {

  WlcProvider();


  final String _url = 'https://apptinkvice.firebaseio.com';

  Future<bool> crearWlc(WlcModel wlc) async {

    final url = '$_url/wlcs.json';
    final resp = await http.post(url, body: wlcModelToJson(wlc));

    final decodedData = json.decode(resp.body);
    print( decodedData );

    return true;

  }


  Future<List<WlcModel>> cargarWlcs() async {

    final url ='$_url/wlcs.json';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<WlcModel> wlcs = List(); 

    if ( decodedData == null ) return [];

    decodedData.forEach(( id, wlc) {
      final wlcTemp = WlcModel.fromJson(wlc);
      wlcTemp.id = id;
      wlcs.add(wlcTemp);
    });

    print(wlcs);

    return wlcs;

  }
}

//wlc_provider
import 'dart:convert';
import 'package:app_deteccion_personas/src/models/wlc_model.dart';
import 'package:http/http.dart' as http;


class WlcProvider {

  WlcProvider();


  final String _url = 'https://apptinkvice.firebaseio.com';

  Future<bool> crearWlc(WlcModel wlc) async {

    final url = '$_url/wlcs';

    final resp = await http.post(url, body: wlcModelToJson(wlc));

    final decodedData = json.decode(resp.body);

    print( decodedData );

    return true;

  }
}

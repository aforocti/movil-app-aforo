import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_deteccion_personas/src/models/client_model.dart';

class ClientsProvider {
  final String _url = 'https://apptinkvice.firebaseio.com';

  Future<bool> crearClient(ClientModel client) async {

    final url = '$_url/clients';

    final resp = await http.post(url, body: clientModelToJson(client));

    final decodedData = json.decode(resp.body);

    print( decodedData );

    return true;

  }
}

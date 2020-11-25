//ap_provider
import 'dart:convert';
import 'package:app_deteccion_personas/src/models/ap_model.dart';
import 'package:http/http.dart' as http;

class ApProvider {
  final String _url = 'https://apptinkvice.firebaseio.com';

  Future<bool> crearAp( ApModel ap ) async {

    final url = '$_url/aps.json';
    final resp = await http.post( url, body: apModelToJson( ap ));
    print( json.decode( resp.body ));
    return true;

  }

  Future<ApModel> cargarAp(String id) async {
    final url = '$_url/aps/$id.json';
    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    if (decodedData == null) return null;
    final temp = ApModel.fromJson(decodedData);
    temp.id = id;
    return temp;
  }

  Future<List<ApModel>> cargarAps() async {

    final url ='$_url/aps.json';
    final resp = await http.get( url );

    final Map<String, dynamic> decodedData = json.decode( resp.body );

    if ( decodedData == null ) return [];

    final List<ApModel> aps = List(); 

    decodedData.forEach(( id, ap ) {
      final temp = ApModel.fromJson( ap );
      temp.id = id;
      aps.add( temp );
    });

    // print( 'CARGAR APs' );
    // print( aps );

    return aps;

  }
}

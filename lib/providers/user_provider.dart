import 'dart:convert';
import 'package:app_deteccion_personas/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'api_url.dart';

class UserProvider {
  UserProvider();

  final String _url = ApiUrl().getUrl();

  Future<bool> crearUser(String user, String token) async {
    final body = json.encode({"user": user, "network_id": token});
    Map<String,String> headers = {
      'Content-type':'application/json',
      'Accept':'application/json'
    };
    final url = '$_url/api/users';
    await http.post(url,
        headers:headers,
        body: body);
    return true;
  }

  Future<UserModel> getUserByName(String name) async {
    final url = '$_url/api/name/$name/users';
    final resp = await http.get(url);
    print(resp);
    List decodedData = json.decode(resp.body);
    if (decodedData.isEmpty) return null;

    final user = UserModel.fromJson(decodedData[0]);
    return user;
  }
}

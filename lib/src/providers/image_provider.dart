import 'dart:convert';
import 'dart:io';
import 'package:app_deteccion_personas/src/models/image_model.dart';
import 'package:app_deteccion_personas/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

class ImagenProvider {
  final _prefs = PreferenciasUsuario();

  final String _url =
      'https://us-central1-backendapptinkvice.cloudfunctions.net/app';

  Future<String> subirImagen(File imagen, String piso) async {
    final urlclodinary = Uri.parse(
        'https://api.cloudinary.com/v1_1/dyit8ftt7/image/upload?upload_preset=usgahwzi');
    final mimeType = mime(imagen.path).split('/');

    final imageUploadRequest = http.MultipartRequest('POST', urlclodinary);

    final file = await http.MultipartFile.fromPath('file', imagen.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('algo salió mal');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    print(respData);
    final url = '$_url/api/network/${_prefs.tokenNetwork}/images';
    final result = await http
        .post(url, body: {"url": respData['secure_url'], "piso": piso});
    print(result.statusCode);
    return respData['secure_url'];
  }

  Future<List<ImageModel>> cargarImages() async {
    final url = '$_url/api/network/${_prefs.tokenNetwork}/images';
    final result = await http.get(url);
    if (result.statusCode != 200)
      return [];
    else {
      final List<dynamic> decodedData = json.decode(result.body);
      final images = Images.fromJsonList(decodedData);
      return images.items;
    }
  }

  Future<ImageModel> cargarImageByPiso(String piso) async {
    final url = '$_url/api/network/${_prefs.tokenNetwork}/Images/$piso';
    final resp = await http.get(url);
    final List<dynamic> decodedData = json.decode(resp.body);
    final wlcs = new Images.fromJsonList(decodedData);
    return wlcs.items[0];
  }
}

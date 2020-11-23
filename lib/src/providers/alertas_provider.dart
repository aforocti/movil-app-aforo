import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;



class _MenuProvider {

  List<dynamic> alerta = [];

  _MenuProvider(){
    cargarData();
      }
    
    Future<List<dynamic>> cargarData() async {

      final resp = await rootBundle.loadString('data/alertas.json');
        
          Map dataMap = json.decode(resp);
          print(dataMap['alertas']);
          alerta= dataMap['alertas'];
      
      return alerta;


    }

}

final menuProvider = new _MenuProvider();
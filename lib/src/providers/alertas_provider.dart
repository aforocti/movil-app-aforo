
import 'package:flutter/services.dart' show rootBundle;

class _MenuProvider {

  List<dynamic> alertas = [];

  _MenuProvider(){
    cargarData();
      }
    
    cargarData() {

      rootBundle.loadString('data/alertas.json')
        .then((data){
          print (data);
        });
    }

}

final menuProvider = new _MenuProvider();
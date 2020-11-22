import 'package:app_deteccion_personas/src/providers/alertas_provider.dart';
import 'package:flutter/material.dart';

class HistorialPage extends StatelessWidget {
  const HistorialPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight - 15),
        child: Container(
          color: Color.fromRGBO(239, 218, 213, 1.0),
          child: Tab(child: Text('HISTORIAL',style: TextStyle(color: Color.fromRGBO(10, 52, 68, 1.0),fontSize: 17))),
        ),
      ),
      body: _lista()
          );
        }
      
        Widget _lista() {
          print (menuProvider.alertas);

          return ListView(
            children: _listaHistorial(),
          );
        }
            
        List<Widget> _listaHistorial() {
          return [
            ListTile()
          ];
        }
}

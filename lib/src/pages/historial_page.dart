import 'package:app_deteccion_personas/src/providers/alertas_provider.dart';
import 'package:flutter/material.dart';

import '../preferencias_usuario/preferencias_usuario.dart';
import '../utils/utils.dart' as u;

class HistorialPage extends StatelessWidget {
  // const HistorialPage({Key key}) : super(key: key);

  final PreferenciasUsuario prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight - 15),
        child: Container(
          color: (prefs.colorSecundario) ? u.getColor('color6t5') : u.getColor('color2'),
          child: Tab(
            child: Text(
              'HISTORIAL',
              style: TextStyle(
                color: Color.fromRGBO(10, 52, 68, 1.0), fontSize: 18, 
                fontWeight: FontWeight.w600
              )
            )
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical:10.0),
        child: _lista()
      )
    );
  }
      
  Widget _lista() {
    return FutureBuilder(
      future: menuProvider.cargarData(),
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
        return ListView(
          children: _listaHistorial(snapshot.data),
        );
      },
    );
  }
    
  List<Widget> _listaHistorial(List<dynamic>data) {
    final List<Widget> alerta =[];
    data.forEach ((opt) {
      final widgetTemp = Card(
        color: Color.fromRGBO(247, 243, 241, 1.0),
        elevation: 5.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          child: ListTile(
            title: Text(opt['area'], style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
            leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(width: 1.0, color: Colors.black26)
                )
              ),
              child: Icon(Icons.warning, color: Colors.red, size:30.0)), 
            subtitle: Text("${opt['hora']} - ${opt['fecha']}", style: TextStyle(color: Colors.black), textAlign: TextAlign.right,),
            dense: true,
          ),
        ),
      );
      alerta..add(widgetTemp);
    });
    return alerta;
  }
}

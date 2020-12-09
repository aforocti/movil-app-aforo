import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:app_deteccion_personas/src/models/alert_model.dart';
import 'package:app_deteccion_personas/src/providers/alert_provider.dart';
import 'package:app_deteccion_personas/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:app_deteccion_personas/src/utils/utils.dart' as utils;

class HistorialPage extends StatelessWidget {

  final prefs = new PreferenciasUsuario();
  final alertProvider = new AlertProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight - 15),
        child: Container(
          color:utils.setColor('color6t5', 'color2'),
          child: Tab(
            child: Text( 'HISTORIAL', style: TextStyle(
                color: Color.fromRGBO(10, 52, 68, 1.0), fontSize: 18, 
                fontWeight: FontWeight.w600
            ))
          ),
        ),
      ),
      body: Container(
        child: _lista()
      )
    );
  }
      
  Widget _lista() {
    return FutureBuilder(
      future: alertProvider.cargarAlerts(),
      builder: (BuildContext context, AsyncSnapshot<List<AlertModel>> snapshot) {
        if (snapshot.hasData) {
          final alerts = snapshot.data;
          return ListView.builder(
            itemCount: alerts.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, i) => _listaHistorial(alerts[i]),
          );
        } else {
          return Center( child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromRGBO(241, 94, 74, 1.0))
          ));
        }
      },
    );
  }
    
  Widget _listaHistorial(AlertModel alert) {
    return Card(
      color: utils.getColor('color3t1'),
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(alert.area, style: TextStyle(fontSize: 18.0)),
          ),
          subtitle: Text('${alert.hour} ${alert.date}'),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
              border: Border( right: BorderSide(width: 1.0, color: Colors.black26))
            ),
            child: Icon(
                Icons.warning, color: utils.getColor('color4'), size:30.0)),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('dispositivos'),
              SizedBox(height: 5.0),
              Text('${alert.deviceNumber}', style: TextStyle(fontSize: 19.0))
            ],
          ), 
          dense: true,
        ),
      ),
    );
  }
}

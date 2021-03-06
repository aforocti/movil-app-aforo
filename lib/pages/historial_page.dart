import 'package:app_deteccion_personas/widgets/varios_widget.dart';
import 'package:flutter/material.dart';
import 'package:app_deteccion_personas/models/alert_model.dart';
import 'package:app_deteccion_personas/providers/alert_provider.dart';
import 'package:app_deteccion_personas/utils/utils.dart' as utils;

class HistorialPage extends StatelessWidget {
  final alertProvider = new AlertProvider();
  final _texto =
      'Una vez que se ejecute Tinkvice SSH, las alertas que lleguen se registrarán aqui';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight - 15),
          child: Container(
            color: utils.setColor('color6t5', 'color2'),
            child: Tab(
                child: Text('HISTORY OF ALERTS',
                    style: TextStyle(
                      color: utils.getColor('color6'), fontSize: 18))),
          ),
        ),
        body: Container(child: _lista()));
  }

  Widget _lista() {
    return FutureBuilder(
      future: alertProvider.cargarAlerts(),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return Column(
            children: [
              utils.errorInfo("Error en la Conexión", Colors.red),
              Expanded(
                  child: utils.iconFont(Icons.wifi_off, context, '')
              )
            ],
          );
        } else if (snapshot.hasData) {
          if (snapshot.data.isEmpty) {
            return Column(
              children: [
                utils.errorInfo('Sin alertas', Colors.purple),
                Expanded(
                  child: utils.iconFont(Icons.history, context, _texto)
                ) 
              ],
            );
          } else {
            final alerts = snapshot.data;
            return ListView.builder(
              itemCount: alerts.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, i) => _listaHistorial(alerts[i]),
            );
          }
        } else {
          return circularProgressIndicatorWidget();
        }
      },
    );
  }

  Widget _listaHistorial(AlertModel alert) {
    return Card(
      color: (alert.type == "0") ? Color.fromRGBO(124,235,125,1): utils.getColor('color3t1'),
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(alert.area, style: TextStyle(fontSize: 18.0)),
          ),
          subtitle: Text('${alert.date} - ${alert.hour}'),
          leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(width: 1.0, color: Colors.black26))),
              child: Icon((alert.type == "0") ? Icons.done_outline_sharp : Icons.warning,  
                  color: (alert.type == "0") ? Color.fromRGBO(44,155,45,1) : utils.getColor('color4'), size: 30.0)),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Devices', style: TextStyle(fontSize: 12.0)),
              Text('${alert.deviceNumber}', style: TextStyle(fontSize: 19.0))
            ],
          ),
          dense: true,
        ),
      ),
    );
  }
}

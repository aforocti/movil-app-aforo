
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:app_deteccion_personas/src/utils/utils.dart' as utils;
import 'package:app_deteccion_personas/src/providers/wlc_provider.dart';
import 'package:app_deteccion_personas/src/providers/ap_provider.dart';
import 'package:app_deteccion_personas/src/models/wlc_model.dart';
import 'package:app_deteccion_personas/src/models/ap_model.dart';
import 'package:expandable/expandable.dart';

class DatosPage extends StatefulWidget {
  @override
  _DatosPageState createState() => _DatosPageState();
}

class _DatosPageState extends State<DatosPage> {
  @override
  void initState() {
    super.initState();
  }

  final wlcProvider = new WlcProvider();
  final apProvider = new ApProvider();
  int limiteInt = 0;
  int pisoInt   = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(child: _crearListado()));
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: apProvider.cargarWlcsAps(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          final wlcs = snapshot.data;
          return ListView.builder(
            itemCount: wlcs.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, i) => _crearCard(wlcs[i]),
          );
        } else {
          return Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromRGBO(241, 94, 74, 1.0))));
        }
      },
    );
  }

  Widget _crearCard(WlcModel wlcModel) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.only(top: 14.0, left: 10.0, right: 10.0),
      child: ScrollOnExpand(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: ExpandablePanel(
            theme: const ExpandableThemeData(
              headerAlignment: ExpandablePanelHeaderAlignment.center,
              iconColor: Colors.black,
            ),
            header: Container(
              decoration: BoxDecoration(color: utils.getColor('color3t1')),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text('${wlcModel.productName}'),
                        subtitle: Text('${wlcModel.mac}'),
                        trailing: Text('en red: 5'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            expanded: buildList(wlcModel.aps),
          ),
        ),
      ),
    ));
  }

  buildList(List<ApModel> aps) {
    return Column(children: makeAps(aps));
  }

  List<Widget> makeAps(List<ApModel> aps) {
    List<Widget> list = [];
    for (var item in aps) {
      list.add(Container(
        decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: Colors.black12)),
        child: ListTile(
          leading: Text("AP",
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
          title: Text(item.name),
          subtitle: Text(item.model),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Limite: ${item.limit}'),
                    Text('Piso: ${item.piso}'),
                  ],
                ),
                onTap: () {
                  _actualizarAp(context, item.limit, item.piso, item.mac, limiteInt, pisoInt);
                  setState(() {}); 
                } 
              ),
            ],
          ),
        ),
      ));
    }
    return list;
  }

  void _agregar() { setState(() => limiteInt++); }

  void _sustraer() { setState(() => limiteInt--); }

  _actualizarAp(BuildContext context, String limit, String piso, String mac, int limite, int floor) {
    limiteInt = int.parse(limit);
    pisoInt   = int.parse(piso);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Actualizar'),
            content: Column( children: [
              Row( children: [
                Text('piso'),
                Expanded(child: Container()),
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    setState(() {});
                  }
                ),
                Text('$limiteInt', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    setState(() {});
                  }
                )
                ]
              ),
              Row( children: [
                Text('Límite'),
                Expanded(child: Container()),
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: _sustraer
                ),
                Text('$limiteInt', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: _agregar
                )
                ]
              ),
              
            ],
            mainAxisSize: MainAxisSize.min,
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancelar',
                      style: TextStyle(color: Color.fromRGBO(10, 52, 68, 1.0)))),
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Ok',
                      style: TextStyle(color: Color.fromRGBO(10, 52, 68, 1.0))))
            ],
          );
        });
  }
}

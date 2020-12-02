// import 'package:app_deteccion_personas/src/models/ap_model.dart';
// import 'package:app_deteccion_personas/src/providers/ap_provider.dart';
import 'dart:ui';

import 'package:app_deteccion_personas/src/models/ap_model.dart';
import 'package:app_deteccion_personas/src/models/wlc_model.dart';
import 'package:app_deteccion_personas/src/providers/ap_provider.dart';
import 'package:app_deteccion_personas/src/providers/wlc_provider.dart';
import 'package:app_deteccion_personas/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

class DatosPage extends StatefulWidget {
  @override
  _DatosPageState createState() => _DatosPageState();
}

class _DatosPageState extends State<DatosPage> {
  final wlcProvider = new WlcProvider();
  final apProvider = new ApProvider();
  final List<ApModel> apList = [
    new ApModel(id: 'dsafsdf',mac: '80:e8:6f:d0:0d:40',model: "AIR-AP1852E-A-K9",name: "Domo_Teleco2"),
    new ApModel(id: 'dsafsdf',mac: '80:e8:6f:d0:0e:80',model: "AIR-AP1852E-A-K9",name: "Sala"),
    new ApModel(id: 'dsafsdf',mac: '80:e8:6f:d0:0e:a0',model: "AIR-AP1852E-A-K9",name: "Domo_Teleco1"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: _crearListado()),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: wlcProvider.cargarWlcs(),
      builder: (BuildContext context, AsyncSnapshot<List<WlcModel>> snapshot) {
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
              decoration: BoxDecoration(
                // color: Color.fromRGBO(255, 227, 129, 1.0),
                color: getColor('color3t1')
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        // tileColor: getColor('color3t1'),
                        title: Text('${wlcModel.productName}'),
                        subtitle: Text('${wlcModel.mac}'),
                        trailing: Text('en red: 5'),
                        // trailing: Icon(Icons.crop_square, size: 40.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            expanded: buildList(),
          ),
        ),
      ),
    ));
  }

  buildItem(ApModel ap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListTile(
        leading: Text("AP",style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
        title: Text(ap.name),
        subtitle: Text('Model: ${ap.model}'),
      ),
    );
  }

  buildList() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: <Widget>[
            buildItem(apList[0]),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: Colors.black26,
              ),
            ),
            buildItem(apList[1]),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: Colors.black26,
              ),
            ),
            buildItem(apList[2]),
        ],
      ),
    );
  }
}

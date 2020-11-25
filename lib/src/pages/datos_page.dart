// import 'package:app_deteccion_personas/src/models/ap_model.dart';
// import 'package:app_deteccion_personas/src/providers/ap_provider.dart';
import 'package:app_deteccion_personas/src/models/wlc_model.dart';
import 'package:app_deteccion_personas/src/providers/ap_provider.dart';
import 'package:app_deteccion_personas/src/providers/wlc_provider.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

class DatosPage extends StatefulWidget {
  @override
  _DatosPageState createState() => _DatosPageState();
}

class _DatosPageState extends State<DatosPage> {
  final wlcProvider = new WlcProvider();
  final apProvider = new ApProvider();

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
      padding: const EdgeInsets.all(10),
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
                color: Color.fromRGBO(255, 227, 129, 1.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text('${wlcModel.productName}'),
                        subtitle: Text("Clientes: 7, Intrusos: 3"),
                        trailing: Icon(Icons.crop_square, size: 40.0),
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

  buildItem(String label) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(label),
    );
  }

  buildList() {
    return Column(
      children: <Widget>[
        for (var i in [1, 2, 3, 4]) buildItem("AP $i"),
      ],
    );
  }
}

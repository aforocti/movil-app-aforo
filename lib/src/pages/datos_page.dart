import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

class DatosPage extends StatefulWidget {
  @override
  _DatosPageState createState() => _DatosPageState();
}

class _DatosPageState extends State<DatosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExpandableTheme(
        data: const ExpandableThemeData(
                iconColor: Colors.blue,
                useInkWell: true,
            ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            Card3(),
            Card3(),
            Card3(),
            Card3(),
            Card3(),
            Card3(),
            Card3(),
          ],
        ),
      ),
    );
  }
}

class Card3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ScrollOnExpand(
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    // tapBodyToExpand: true,
                    // tapBodyToCollapse: true,
                    // hasIcon: false, // TOMAR EN CUENTA SI SE DESEA CAMBIAR EL ESTILO DEL ICONO QUE ABRE EL EXPANDED
                    iconColor: Colors.black,
                  ),
                  header: Container(
                    color: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text('WLC - name1'),
                              subtitle: Text("Clientes: 7, Intrusos: 3"),
                              // leading: Icon(Icons.device_hub),
                              trailing: Icon(Icons.crop_square,size: 40.0),
                            ),
                          ),
                          // ExpandableIcon(   // TOMAR EN CUENTA SI SE DESEA CAMBIAR EL ESTILO DEL ICONO QUE ABRE EL EXPANDED
                          //   theme: const ExpandableThemeData(
                          //     expandIcon: Icons.keyboard_arrow_down,
                          //     collapseIcon: Icons.keyboard_arrow_up,
                          //     iconColor: Colors.white,
                          //     iconSize: 30.0,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  expanded: buildList(),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}

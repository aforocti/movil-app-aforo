import 'package:app_deteccion_personas/src/pages/datos_page.dart';
import 'package:app_deteccion_personas/src/pages/planos_page.dart';
import 'package:flutter/material.dart';

class PrincipalPage extends StatelessWidget {
  const PrincipalPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight - 15),
          child: Container(
            color: Colors.grey,
                child: TabBar(
                  indicatorColor: Colors.black,
                  tabs: [
                    Tab(child: Text('PLANOS', style: TextStyle(color: Colors.white,fontSize: 17))),
                    Tab(child: Text('DATOS', style: TextStyle(color: Colors.white,fontSize: 17)))
                  ],
                )

          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: PlanosPage()
            ),
            Center(
              child: DatosPage()
            )
          ],
        ),
      ),
    );
  }
}

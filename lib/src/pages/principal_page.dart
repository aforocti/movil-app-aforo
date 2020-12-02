import 'package:app_deteccion_personas/src/pages/datos_page.dart';
import 'package:app_deteccion_personas/src/pages/planos_page.dart';
import 'package:flutter/material.dart';

import '../preferencias_usuario/preferencias_usuario.dart';
import '../utils/utils.dart' as utils;

class PrincipalPage extends StatelessWidget {
  // const PrincipalPage({Key key}) : super(key: key); 

  final PreferenciasUsuario prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    final prefs = PreferenciasUsuario();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight - 15),
          child: Container(
              color: utils.setColor('color6t5', 'color2'),
              child: TabBar(
                indicatorColor: Color.fromRGBO(10, 52, 68, 1.0),
                tabs: [
                  Tab(
                    child: Text('PLANOS',
                      style: TextStyle(
                        color: Color.fromRGBO(10, 52, 68, 1.0),
                        fontSize: 17
                      )
                    )
                  ),
                  Tab(
                    child: Text('DATOS',
                      style: TextStyle(
                        color: Color.fromRGBO(10, 52, 68, 1.0),
                        fontSize: 17
                      )
                    )
                  )
                ],
              )),
        ),
        body: TabBarView(
          children: [Center(child: PlanosPage()), Center(child: DatosPage())],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../preferencias_usuario/preferencias_usuario.dart';
import '../utils/utils.dart' as utils;

class GraficasPage extends StatelessWidget {
  // const GraficasPage({Key key}) : super(key: key);

  final PreferenciasUsuario prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight - 15),
        child: Container(
          color: utils.setColor('color6t5', 'color2'),
          child: Tab(
            child: Text(
              'GRÁFICAS',
              style: TextStyle(
                color: Color.fromRGBO(10, 52, 68, 1.0), fontSize: 18,
                fontWeight: FontWeight.w600
              )
            )
          ),
        ),
      ),
      body: Center(
        child: Text('GRAFICAS'),
      ),
    );
  }
}

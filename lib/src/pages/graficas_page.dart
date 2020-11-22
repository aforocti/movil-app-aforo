import 'package:flutter/material.dart';

class GraficasPage extends StatelessWidget {
  const GraficasPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight - 15),
        child: Container(
          color: Color.fromRGBO(239, 218, 213, 1.0),
          child: Tab(child: Text('GRÁFICAS',style: TextStyle(color: Color.fromRGBO(10, 52, 68, 1.0),fontSize: 17))),
        ),
      ),
      body: Center(
        child: Text('GRAFICAS'),
      ),
    );
  }
}

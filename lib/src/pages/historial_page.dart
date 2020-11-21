import 'package:flutter/material.dart';

class HistorialPage extends StatelessWidget {
  const HistorialPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight - 15),
        child: Container(
          color: Colors.grey,
          child: Tab(child: Text('HISTORIAL',style: TextStyle(color: Colors.white,fontSize: 17))),
        ),
      ),
      body: Center(
        child: Text('HISTORIAL'),
      ),
    );
  }
}

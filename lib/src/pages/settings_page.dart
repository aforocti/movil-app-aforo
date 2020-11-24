import 'package:flutter/material.dart';


class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Configuraciones', style: TextStyle(color: Color.fromRGBO(10, 52, 68, 1.0))),
          centerTitle: true,
        ),
        body: Center(child: Text('Settings Page')),
      ),
    );
  }
}
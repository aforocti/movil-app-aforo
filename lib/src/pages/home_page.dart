import 'package:flutter/material.dart';

import 'graficas_page.dart';
import 'historial_page.dart';
import 'mapas_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apliacion')
      ),
      body: _llamarPagina(_currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),
    );
  }

  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: 'hola'),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: 'hola'),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: 'hola'),
        ]);
  }

  Widget _llamarPagina(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return HistorialPage();
      case 1:
        return MapasPage();
      case 2:
        return GraficasPage();
      default:
        return HistorialPage();
    }
  }
}

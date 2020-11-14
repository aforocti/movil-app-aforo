import 'package:flutter/material.dart';

import 'graficas_page.dart';
import 'historial_page.dart';
import 'principal_page.dart';

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
        backgroundColor: Colors.grey,
        title: Text('Tinkvice')
      ),
      body: _llamarPagina(_currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),
    );
  }

  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.grey,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black26,
      iconSize: 35.0,
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() => _currentIndex = index);
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Historial'),
        BottomNavigationBarItem(icon: Icon(Icons.location_searching ), label: 'Principal'),
        // device_hub_outlined, domain, grain, group, group_work. leak_add, location_searching, coronavirus_outlined, people_outline
        // perm_scan_wifi, pearson_search, pin_drop, rss, scatter_plot, track_changes, wifi_outlined, wifi_tethering
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined), label: 'Gráficas'),
      ]
    );
  }

  Widget _llamarPagina(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return HistorialPage();
      case 1:
        return PrincipalPage();
      case 2:
        return GraficasPage();
      default:
        return PrincipalPage();
    }
  }
}

import 'dart:ui';

import 'package:app_deteccion_personas/src/blocs/provider.dart';
import 'package:app_deteccion_personas/src/models/wlc_model.dart';
import 'package:app_deteccion_personas/src/providers/wlc_provider.dart';
import 'package:flutter/material.dart';

import 'graficas_page.dart';
import 'historial_page.dart';
import 'principal_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tinkvice', style: TextStyle(color: Color.fromRGBO(10, 52, 68, 1.0))),
        actions:<Widget> [
          IconButton(
            icon: Icon(Icons.settings_outlined),
            onPressed: () =>  Navigator.pushNamed( context, 'setting' ) 
          ),
          
          SizedBox(width: 10.0)
        ],
        leading: Container(
          padding: EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
          child: Image(
            fit: BoxFit.fill,
            image: AssetImage('assets/ic_appbar.png')
          ),
        ),
        elevation: 10.0,
        shadowColor: Color.fromRGBO(168, 97, 93, 0.5),
        titleSpacing: 6.0,
      ),
      body: _llamarPagina(_currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),
    );
  }

  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Color.fromRGBO(239, 218, 213, 1.0),
      showUnselectedLabels: false,
      showSelectedLabels: false,
      // selectedItemColor: Colors.white,
      unselectedItemColor: Color.fromRGBO(168, 97, 93, 0.4),
      iconSize: 30.0,
      unselectedIconTheme: IconThemeData(
        size: 25.0
      ),
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() => _currentIndex = index);
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.history), 
          label: 'Historial',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_searching),
          label: 'Principal'
        ),
        // device_hub_outlined, domain, grain, group, group_work. leak_add, location_searching, coronavirus_outlined, people_outline
        // perm_scan_wifi, pearson_search, pin_drop, rss, scatter_plot, track_changes, wifi_outlined, wifi_tethering
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_outlined),
          label: 'Gráficas'
        ),
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

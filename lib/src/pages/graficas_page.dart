import 'dart:ui';

import 'package:flutter/material.dart';

class GraficasPage extends StatelessWidget {
  const GraficasPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Colors.grey,
            child: TabBar(
              indicatorColor: Colors.black,
              tabs: [
                Tab(child: Text('GRÁFICAS', style: TextStyle(color: Colors.white, fontSize: 17))),
              ],
            ),
          )
        ),
        body: TabBarView(
          children: [
            Center(
              child: Text('GRAFICAS'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MapasPage extends StatelessWidget {
  const MapasPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            child: SafeArea(
                child: Column(
              children: [
                Expanded(child: Container()),
                TabBar(
                  tabs: [
                    Tab(text: 'Planos'),
                    Tab(text: 'Datos'),
                  ],
                )
              ],
            )),
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Text('Planos'),
            ),
            Center(
              child: Text('Datos'),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class HistorialPage extends StatelessWidget {
  const HistorialPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight - 15),
          child: Container(
            color: Colors.grey,
            child: TabBar(
              indicatorColor: Colors.black,
                  tabs: [
                    Tab(child: Text('HISTORIAL',style: TextStyle(color: Colors.white,fontSize: 17))),
                  ],
                )

          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Text('HISTORIAL'),
            ),
          ],
        ),
      ),
    );
  }
}

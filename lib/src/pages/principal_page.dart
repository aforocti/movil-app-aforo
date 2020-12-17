
import 'package:flutter/material.dart';
import 'package:app_deteccion_personas/src/utils/utils.dart' as utils;

class PrincipalPage extends StatefulWidget {
  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {

  String planta = 'PLANTA BAJA'; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight - 15),
        child: Container(
          color: utils.setColor('color6t5', 'color2'),
          child: Tab(
              child: Text('PLANOS',
                  style: TextStyle(
                      color: Color.fromRGBO(10, 52, 68, 1.0),
                      fontSize: 18,
                      fontWeight: FontWeight.w600))),
        ),
      ),
      floatingActionButton: editedFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        child: Image(
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.fill,
          image: AssetImage('assets/planta_baja_.jpeg'),
        ),
      ),
    );
  }

  Widget editedFab() {
    return Container(
      height: 50.0,
      margin: EdgeInsets.symmetric(horizontal: 50.0),
      decoration: BoxDecoration(
        color: utils.getColor('color3t1'),
        borderRadius: BorderRadius.circular(30.0)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: null
          ),
          divisor(),
          Expanded(child: Container()),
          Text(planta),
          Expanded(child: Container()),
          divisor(),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: null
          )
        ],
      ), 
    );
  }

  Widget divisor() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: Colors.black12)
          )
        ),
    );
  }
}

import 'package:app_deteccion_personas/src/utils/utils.dart' as utils;
import 'package:flutter/material.dart';

class PlanosPage extends StatefulWidget {

  @override
  _PlanosPageState createState() => _PlanosPageState();
}

class _PlanosPageState extends State<PlanosPage> {
  final int planos = 6;

  String planta = 'PLANTA BAJA'; 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: editedFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        child: Image(
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.fill,
          image: AssetImage('assets/planta_baja.jpg'),
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
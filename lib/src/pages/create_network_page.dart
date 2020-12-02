import 'package:flutter/material.dart';

class CreateNetworkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              texto('Si ya cuentas con un token, ingrésalo para acceder a la red'),
              SizedBox(height: 20.0),
              textField(),
              SizedBox(height: 40.0),
              texto('Presionar crear si aún no tienes una red creada'),
              SizedBox(height: 20.0),
              _makeButton(),
            ],
          ),
        ),
      )
    );
  }

  Widget textField() {
    return TextField(
      autofocus: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }

  Widget texto(String texto) {
    return Text(
      texto,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
    );
  }

  Widget _makeButton() {
    return RaisedButton(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text('Crear')),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      elevation: 0.0,
      color: Color.fromRGBO(138, 67, 63, 1.0),
      textColor: Colors.white,
      onPressed: () {},
    );
  }
}
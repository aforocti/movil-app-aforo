import 'package:app_deteccion_personas/src/blocs/provider.dart';
import 'package:app_deteccion_personas/src/providers/usuario_provider.dart';
import 'package:app_deteccion_personas/src/utils/utils.dart' as utils;
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  IconData _iconPassword = Icons.remove_red_eye_outlined;

  final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [_crearFondo(context), _loginForm(context)],
    ));
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final circulo = Container(
      width: size.width * 0.57,
      height: size.width * 0.57,
      decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Color.fromRGBO(231, 210, 205, 1.0),
                blurRadius: 2.0,
                // offset: Offset(0.0, 0.0),
                spreadRadius: 3.0)
          ],
          borderRadius: BorderRadius.circular(size.width * 0.6),
          color: Color.fromRGBO(231, 210, 205, 1.0)),
    );

    final fondo = Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(color: Color.fromRGBO(239, 218, 213, 1.0)),
    );

    return Stack(
      children: [
        fondo,
        Positioned(child: circulo, top: -40.0, left: -40.0),
        Positioned(child: circulo, top: 150.0, right: -90.0),
        SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 40.0), // 40
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(247, 243, 241, 1.0),
                  radius: size.height * 0.1, // h: 0.1
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Image(
                      height: size.height * 0.14,
                      width: size.height * 0.14,
                      fit: BoxFit.fill,
                      image: AssetImage('assets/ic_splash.png'),
                    ),
                  ),
                ),
                SizedBox(height: 10.0, width: double.infinity),
                Text('Iniciar Sesión',
                    style: TextStyle(
                        color: Color.fromRGBO(168, 97, 93, 1.0),
                        fontSize: 25.0)) // 25
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
              child:
                  Container(height: (40.0 + (3 * 25.0) + size.height * 0.2))),
          Container(
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
                color: Color.fromRGBO(247, 243, 241, 1.0),
                borderRadius: BorderRadius.circular(7.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: [
                SizedBox(height: 30.0),
                _userInput(bloc),
                SizedBox(height: 30.0),
                _passwordInput(bloc),
                SizedBox(height: 10.0),
                _textRecovery(),
                SizedBox(height: 40.0),
                _makeButton(bloc),
                SizedBox(height: 30.0),
                _makeReisterButton()
              ],
            ),
          ),
          SizedBox(height: 50.0)
        ],
      ),
    );
  }

  Widget _userInput(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.userStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextField(
          onChanged: bloc.changeUser,

          ///
          autofocus: false,
          decoration: InputDecoration(
            hintText: 'Usuario',
            labelText: 'Usuario',
            errorText: snapshot.error,
            // counterText: snapshot.data,
            icon: Icon(Icons.account_circle),
          ),
        );
      },
    );
  }

  Widget _passwordInput(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextField(
          obscureText: _obscureText,
          onChanged: bloc.changePassword,

          ///
          decoration: InputDecoration(
            icon: Icon(Icons.lock),
            hintText: 'Contraseña',
            labelText: 'Contraseña',
            errorText: snapshot.error,
            // counterText: snapshot.data,
            suffixIcon: IconButton(
              icon: new Icon(_iconPassword),
              onPressed: () => setState(() {
                if (_obscureText) {
                  _iconPassword = Icons.remove_red_eye;
                } else {
                  _iconPassword = Icons.remove_red_eye_outlined;
                }
                _obscureText = !_obscureText;
              }),
            ),
          ),
        );
      },
    );
  }

  Widget _textRecovery() {
    return Row(
      children: [
        Expanded(child: Container()),
        InkWell(
          child: Text("¿Olvidaste Tu Contraseña?",
              style: TextStyle(color: Color.fromRGBO(168, 97, 93, 1.0))),
          onTap: () => print("¿Olvidaste tu contraseña?"),
        ),
      ],
    );
  }

  Widget _makeButton(LoginBloc bloc) {
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text('Ingresar')),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 0.0,
      color: Color.fromRGBO(138, 67, 63, 1.0),
      textColor: Colors.white,
      onPressed: () => _login(context, bloc),
    );
  }

  _login(BuildContext context, LoginBloc bloc) async {


    Map info = await usuarioProvider.login(bloc.user, bloc.password);

    if( info['ok'] ) {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      utils.mostrarAlerta(context, title: 'Error', content:  info['mensaje'] );
    }

  }

  Widget _makeReisterButton() {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      FlatButton(
          child: Text('Crear cuenta'),
          onPressed: () => Navigator.pushReplacementNamed(context, 'register')),
    ]);
  }
}

import 'dart:async';

import 'package:flutter/material.dart';



class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), ()=> Navigator.pushNamed( context, 'login' ));
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget> [
          Container(
            decoration: BoxDecoration(color: Color.fromRGBO(239, 218, 213, 1.0)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(10, 52, 68, 1.0),
                  radius: 60.0,
                  child: Icon(
                    Icons.group,
                    color: Color.fromRGBO(247, 243, 241, 1.0),
                    size: 60.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "TinkVice", 
                  style: TextStyle(
                    fontSize: 50.0, 
                    color: Color.fromRGBO(10, 52, 68, 1.0)
                  )
                )
            ],
          )

        ],
      ),
    );
  }
}
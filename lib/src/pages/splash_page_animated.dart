

import 'package:flutter/material.dart';


class SplashPageAnimated extends StatefulWidget {

  // final Widget child;

  // SplashPage({@required this.child});

  @override
  createState() => _SplashPageStateAnimated();

}

class _SplashPageStateAnimated extends State<SplashPageAnimated> with SingleTickerProviderStateMixin {
  
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller =  AnimationController(
      vsync: this,
      duration: Duration(seconds: 2)
    )..addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacementNamed( context, 'login');
      }
    });
    _animation = Tween(
      begin: 0.0,
      end: 1.0
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return FadeTransition(
      opacity: _animation,
      child: Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget> [
          Container(
            decoration: BoxDecoration(color: Color.fromRGBO(239, 218, 213, 1.0)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
                Image(
                  height: 144.0 + 20.0,
                  width: 144.0 + 20.0,
                  fit: BoxFit.fill,
                  image: AssetImage('assets/ic_splash.png'),
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
    ),
    );
  }
}
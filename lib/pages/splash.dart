import 'dart:async';

import 'package:blueapp/pages/landing.dart';
import 'package:flutter/material.dart';
import 'package:blueapp/theme/colors_app.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  void onDoneLoading() async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LandingScreen()));
  }

  Future<Timer> loadApp() async {
    return new Timer(Duration(seconds: 5), onDoneLoading);
  }

  @override
  void initState() {
    super.initState();
    loadApp();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: ColorsApp.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Image(
              image: new AssetImage('assets/logo.jpg'),
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              'Bienvenido a Rico Pollo',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Roboto',
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:blueapp/pages/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bluetooth',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashScreen(),
      /*Scaffold(
        appBar: AppBar(
          title: Text("Bluetooth"),
        ),
        body: Center(
          child: Text(
            'Bluetooth ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),*/
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothOFFScreen extends StatelessWidget {
  final BluetoothState state;

  const BluetoothOFFScreen({Key key, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.bluetooth_disabled,
                size: 200,
                color: Colors.black12,
              ),
              Text(
                'Bluetooth estado: ${state.toString().substring(15)}',
                style: Theme.of(context)
                    .primaryTextTheme
                    .subhead
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
        ));
  }
}
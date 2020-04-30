import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:blueapp/blocs/bloc_provider.dart';

class ApplicationBloc implements BlocBase {
  FlutterBlue flutterBlue;

  ApplicationBloc() {
    flutterBlue = FlutterBlue.instance;
  }

  Stream<BluetoothState> get bluetoothState => flutterBlue.state;

  Future<dynamic> startScan() =>
      flutterBlue.startScan(timeout: Duration(seconds: 4));

  Future<dynamic> stopScan() => flutterBlue.stopScan();

  Stream<List<BluetoothDevice>> getDevices() =>
      Stream.periodic(Duration(seconds: 2))
          .asyncMap((_) => flutterBlue.connectedDevices);

  Stream<List<ScanResult>> get scanResults => flutterBlue.scanResults;

  Stream<bool> get isScanning => flutterBlue.isScanning;

  @override
  void dispose() {}
}

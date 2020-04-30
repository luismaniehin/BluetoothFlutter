import 'package:blueapp/blocs/application_bloc.dart';
import 'package:blueapp/blocs/bloc_provider.dart';
import 'package:blueapp/pages/bluetooth_off.dart';
import 'package:blueapp/pages/find_devices.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ApplicationBloc>(
      bloc: ApplicationBloc(),
      child: SelectorScreen(),
    );
  }
}

class SelectorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);

    return StreamBuilder<BluetoothState>(
      stream: bloc.bluetoothState,
      initialData: BluetoothState.unknown,
      builder: (BuildContext context, AsyncSnapshot<BluetoothState> snapshot) {
        final state = snapshot.data;

        if (state == BluetoothState.on) return FindDevicesScreen();

        return BluetoothOFFScreen(state: state);
      },
    );
  }
}

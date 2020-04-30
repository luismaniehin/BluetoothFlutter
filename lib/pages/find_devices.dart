import 'package:blueapp/blocs/application_bloc.dart';
import 'package:blueapp/blocs/bloc_provider.dart';
import 'package:blueapp/pages/device.dart';
import 'package:blueapp/widgets/scan_result_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class FindDevicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar dispositivos ...'),
      ),
      body: RefreshIndicator(
        onRefresh: () => bloc.startScan(),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamBuilder<List<BluetoothDevice>>(
                stream: bloc.getDevices(),
                initialData: [],
                builder: (BuildContext context,
                    AsyncSnapshot<List<BluetoothDevice>> snapshot) {
                  return Column(
                    children: snapshot.data
                        .map(
                          (d) => ListTile(
                            title: Text(d.name),
                            subtitle: Text(d.id.toString()),
                            trailing: StreamBuilder<BluetoothDeviceState>(
                              stream: d.state,
                              initialData: BluetoothDeviceState.disconnected,
                              builder: (c, snapshot) {
                                if (snapshot.data ==
                                    BluetoothDeviceState.connected) {
                                  return RaisedButton(
                                    child: Text('abrir'),
                                    onPressed: () => Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return DeviceScreen(device: d);
                                    })),
                                  );
                                }
                                return Text(snapshot.data.toString());
                              },
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
              StreamBuilder<List<ScanResult>>(
                stream: bloc.scanResults,
                initialData: [],
                builder: (BuildContext context,
                    AsyncSnapshot<List<ScanResult>> snapshot) {
                  return Column(
                    children: snapshot.data
                        .where((r) => r.device.name.length > 0)
                        .map((r) => ScanResultTile(
                              result: r,
                              onTap: () => Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                r.device.connect();
                                return DeviceScreen(device: r.device);
                              })),
                            ))
                        .toList(),
                  );
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: bloc.isScanning,
        initialData: false,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data) {
            return FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: () => bloc.stopScan(),
              backgroundColor: Colors.red,
            );
          } else {
            return FloatingActionButton(
              child: Icon(Icons.search),
              onPressed: () => bloc.startScan(),
              backgroundColor: Colors.blue,
            );
          }
        },
      ),
    );
  }
}

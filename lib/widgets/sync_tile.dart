import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class SyncTile extends StatefulWidget {
  final BluetoothCharacteristic char;

  const SyncTile({Key key, this.char}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _SyncTileState(char: char);
  }
}

class _SyncTileState extends State<SyncTile> {
  final BluetoothCharacteristic char;

  _SyncTileState({this.char});

  void _syncClick() {
    char.setNotifyValue(!char.isNotifying).then((val) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: RaisedButton.icon(
        icon: new Icon(char.isNotifying ? Icons.sync_disabled : Icons.sync),
        label: char.isNotifying ? Text('stop sync') : Text('activate sync'),
        color: Colors.black,
        textColor: Colors.white,
        onPressed: () {
          _syncClick();
        },
      ),
    );
  }
}
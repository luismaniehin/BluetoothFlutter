import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class ScanResultTile extends StatelessWidget {
  final ScanResult result;
  final VoidCallback onTap;

  const ScanResultTile({Key key, this.result, this.onTap}) : super(key: key);

  Widget _buildTitle(BuildContext context) {
    if (result.device.name.length > 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            result.device.name,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            result.device.id.toString(),
            style: Theme.of(context).textTheme.caption,
          )
        ],
      );
    } else {
      return Text(result.device.id.toString());
    }
  }

  Widget _buildAdvRow(BuildContext context, String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.caption,
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .apply(color: Colors.black),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  String getNiceHexArray(List<int> bytes) {
    return '[${bytes.map((i) => i.toRadixString(16).padLeft(2, '0')).join((', '))}]'
        .toUpperCase();
  }

  String getNiceManufacturerData(Map<int, List<int>> data) {
    if (data.isEmpty) return null;

    List<String> res = [];

    data.forEach((id, bytes) {
      res.add(
          '${id.toRadixString(16).toUpperCase()}:${getNiceHexArray(bytes)}');
    });

    return res.join(', ');
  }

  String getNiceServiceData(Map<String, List<int>> data) {
    if (data.isEmpty) return null;

    List<String> res = [];

    data.forEach((id, bytes) {
      res.add('${id.toUpperCase()}:${getNiceHexArray(bytes)}');
    });

    return res.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: _buildTitle(context),
      leading: Text(result.rssi.toString()),
      trailing: RaisedButton(
        child: Text('conectar'),
        color: Colors.black,
        textColor: Colors.white,
        onPressed: (result.advertisementData.connectable) ? onTap : null,
      ),
      children: <Widget>[
        _buildAdvRow(
            context, 'complete local name', result.advertisementData.localName),
        _buildAdvRow(context, 'tx power level',
            '${result.advertisementData.txPowerLevel ?? 'N/A'}'),
        _buildAdvRow(
            context,
            'manufacturer data',
            getNiceManufacturerData(
                    result.advertisementData.manufacturerData) ??
                'N/A'),
        _buildAdvRow(
            context,
            'service uuids',
            (result.advertisementData.serviceUuids.isNotEmpty)
                ? result.advertisementData.serviceUuids.join(', ').toUpperCase()
                : 'N/A'),
        _buildAdvRow(context, 'service data',
            getNiceServiceData(result.advertisementData.serviceData) ?? 'N/A'),
      ],
    );
  }
}

import 'package:countries_app/model/country.dart';
import 'package:flutter/material.dart';

class TileInfo extends StatelessWidget {
  final Country country;

  const TileInfo({Key key, @required this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 8.0),
            Text('Native: ${country.nativeName}'),
            SizedBox(height: 8.0),
            Text('Currency: ${country.currency}'),
            SizedBox(height: 8.0),
            Text('Phone code: ${country.phone}'),
            SizedBox(height: 8.0),
            Text('Languages: ${country.languages}')
          ],
        ),
      ),
    );
  }
}

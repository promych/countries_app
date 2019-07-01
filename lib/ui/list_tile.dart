import 'package:countries_app/app/app_manager.dart';
import 'package:countries_app/model/country.dart';
import 'package:countries_app/ui/tile_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomListTile extends StatefulWidget {
  final Country country;

  const CustomListTile({Key key, @required this.country}) : super(key: key);

  @override
  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppManager>(context);
    final countryName = widget.country.name;
    bool isSelected = countryName == app.selectedCountry;

    return GestureDetector(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: double.infinity,
                  color: Colors.transparent,
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    fit: StackFit.loose,
                    children: <Widget>[
                      Text(
                        '${widget.country.emoji}',
                        style: TextStyle(fontSize: 28.0),
                      ),
                      Positioned(
                        left: 40.0,
                        top: 0.0,
                        bottom: 0.0,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            countryName,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: isSelected
                                  ? CupertinoColors.activeBlue
                                  : CupertinoColors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 250),
                height: isSelected ? 130.0 : 0.0,
                child: TileInfo(country: widget.country),
              ),
              Container(
                height: 1.0,
                color: CupertinoColors.lightBackgroundGray,
              )
            ],
          ),
        ),
        onTap: () async {
          if (isSelected) {
            app.selectedCountry = '';
            setState(() => isSelected = false);
          } else {
            app.selectedCountry = countryName;
            await app.moveMarker(countryName);
          }
        });
  }
}

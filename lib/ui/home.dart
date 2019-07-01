import 'package:countries_app/app/app_manager.dart';
import 'package:countries_app/ui/list_tile.dart';
import 'package:countries_app/ui/search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller;
  FocusNode _focusNode;
  String _terms = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()..addListener(_onTextChanged);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _terms = _controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppManager>(context);
    final countries = app.filter(_terms);

    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: GoogleMap(
              myLocationButtonEnabled: false,
              initialCameraPosition:
                  CameraPosition(target: AppManager.startLocation),
              onMapCreated: app.mapController.complete,
              markers: app.markers,
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: <Widget>[
                SearchBar(
                  controller: _controller,
                  focusNode: _focusNode,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: countries.length,
                    itemBuilder: (BuildContext context, int index) =>
                        CustomListTile(country: countries[index]),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

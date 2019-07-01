import 'dart:async';

import 'package:countries_app/model/country.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppManager extends ChangeNotifier {
  List<Country> _countries;
  Completer<GoogleMapController> _mapController;
  Marker _marker;
  String selectedCountry = '';

  static final LatLng startLocation = LatLng(
    57.42796133580664,
    -122.085749655962,
  );

  Completer<GoogleMapController> get mapController => _mapController;
  Set<Marker> get markers => Set<Marker>.of([_marker]);
  List<Country> get countries => _countries ?? [];

  AppManager.instance(queryResult)
      : _countries =
            List.from(queryResult['countries']).map(Country.fromMap).toList(),
        _mapController = Completer(),
        _marker = Marker(
          markerId: MarkerId('current'),
          position: startLocation,
        );

  List<Country> filter(String terms) {
    return _countries.where((country) {
      return country.name.toLowerCase().contains(terms.toLowerCase());
    }).toList();
  }

  moveMarker(String countryName) async {
    final GoogleMapController controller = await _mapController.future;
    LatLng location;

    await Geocoder.local.findAddressesFromQuery(countryName).then((value) {
      location = LatLng(
        value.first.coordinates.latitude,
        value.first.coordinates.longitude,
      );
    });

    _marker = Marker(
      markerId: MarkerId(countryName),
      position: location,
    );

    notifyListeners();

    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: location),
      ),
    );
  }
}

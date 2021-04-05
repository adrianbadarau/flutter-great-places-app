import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places_app/helpers/db_helper.dart';
import 'package:great_places_app/helpers/location_helper.dart';
import 'package:great_places_app/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image, PlaceLocation location) async {
    final stringAddress = await LocationHelper.getPlaceAddress(location.lat, location.long);
    final newLocation = PlaceLocation(lat: location.lat, long: location.long, address: stringAddress);
    final newPlace = Place(id: DateTime.now().toIso8601String(), title: title, location: newLocation, image: image);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('places', newPlace.toJson());
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('places');
    _items = dataList
        .map((item) => Place(
              id: item['id'],
              title: item['title'],
              location: PlaceLocation(lat: item['loc_lat'], long: item['loc_lat'], address: item['loc_address']),
              image: File(item['image']),
            ))
        .toList();
    notifyListeners();
  }

  Place findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}

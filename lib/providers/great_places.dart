import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:great_places_app/helpers/db_helper.dart';
import 'package:great_places_app/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(id: DateTime.now().toIso8601String(), title: title, location: null, image: image);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('places', newPlace.toJson());
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('places');
    _items = dataList.map((item) => Place(id: item['id'], title: item['title'], location: null, image: File(item['image']))).toList();
    notifyListeners();
  }
}

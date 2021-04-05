import 'dart:io';
import 'package:flutter/foundation.dart';

class PlaceLocation {
  final double lat;
  final double long;
  final String address;

  const PlaceLocation({@required this.lat, @required this.long, this.address});

  Map<String, Object> toJson() {
    return {'lat': lat, 'long': long, 'address': address};
  }
}

class Place {
  String id;
  String title;
  PlaceLocation location;
  File image;

  Place({@required this.id, @required this.title, @required this.location, @required this.image});

  Map<String, Object> toJson() {
    return {'id': id, 'title': title, /*'location': location.toJson(),*/ 'image': image.path};
  }
}

import 'dart:io';
import 'package:flutter/foundation.dart';

class PlaceLocation {
  final double lat;
  final double long;
  final String address;

  const PlaceLocation({@required this.lat, @required this.long, this.address});

  Map<String, Object> toJson() {
    return {'loc_lat': lat, 'loc_long': long, 'loc_address': address};
  }
}

class Place {
  String id;
  String title;
  PlaceLocation location;
  File image;

  Place({@required this.id, @required this.title, @required this.location, @required this.image});

  Map<String, Object> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image.path,
      'loc_lat': location.lat,
      'loc_long': location.long,
      'loc_address': location.address
    };
  }
}

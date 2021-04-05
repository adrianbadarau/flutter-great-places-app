import 'dart:io';
import 'package:flutter/foundation.dart';

class PlaceLocation {
  double lat;
  double long;
  String address;

  PlaceLocation({@required this.lat, @required this.long, this.address});
}

class Place {
  String id;
  String title;
  PlaceLocation location;
  File image;

  Place({@required this.id, @required this.title, @required this.location, @required this.image});
}

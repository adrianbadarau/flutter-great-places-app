import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places_app/helpers/location_helper.dart';
import 'package:great_places_app/screens/map_screen.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  Future<void> _getCurentUserLocation() async {
    final locData = await Location().getLocation();
    setState(() {
      _previewImageUrl = LocationHelper.generateLocationPreviewImage(lat: locData.latitude, long: locData.longitude);
    });
    print(locData);
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation =
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => MapScreen(isSelecting: true), fullscreenDialog: true));
    if (selectedLocation != null) {
      setState(() {
        _previewImageUrl = LocationHelper.generateLocationPreviewImage(lat: selectedLocation.latitude, long: selectedLocation.longitude);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 270,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _previewImageUrl == null
              ? Text('No location chosen', textAlign: TextAlign.center)
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              onPressed: _getCurentUserLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text('Select On Map'),
              textColor: Theme.of(context).primaryColor,
            )
          ],
        ),
      ],
    );
  }
}

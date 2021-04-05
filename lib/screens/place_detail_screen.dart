import 'package:flutter/material.dart';
import 'package:great_places_app/providers/great_places.dart';
import 'package:great_places_app/screens/map_screen.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = 'place-detail';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace = Provider.of<GreatPlaces>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(selectedPlace.image, fit: BoxFit.cover, width: double.infinity),
          ),
          SizedBox(width: 10),
          Text(selectedPlace.location.address, textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.grey)),
          SizedBox(width: 10),
          FlatButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MapScreen(
                          initialLocation: selectedPlace.location,
                        ),
                    fullscreenDialog: true));
              },
              child: Text('View on map'),
              textColor: Theme.of(context).primaryColor)
        ],
      ),
    );
  }
}

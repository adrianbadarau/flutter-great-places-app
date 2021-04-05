import 'package:flutter/material.dart';
import 'package:great_places_app/providers/great_places.dart';
import 'package:great_places_app/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              }),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<GreatPlaces>(
                builder: (context, greatPlaces, child) => greatPlaces.items.length <= 0
                    ? child
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          final item = greatPlaces.items[index];
                          return ListTile(
                            leading: CircleAvatar(backgroundImage: FileImage(item.image)),
                            title: Text(item.title),
                            onTap: () {
                              // go to details page
                            },
                          );
                        },
                        itemCount: greatPlaces.items.length,
                      ),
                child: Center(
                  child: const Text('No places yet ...'),
                ),
              ),
      ),
    );
  }
}

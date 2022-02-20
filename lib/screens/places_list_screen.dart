import 'package:flutter/material.dart';
import 'package:great_place_app/providers/great_places_provider.dart';
import 'package:great_place_app/screens/add_place_screen.dart';
import 'package:great_place_app/screens/all_markers.dart';
import 'package:great_place_app/screens/custom_info.dart';
import 'package:great_place_app/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Places"),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routName);
              }),
          IconButton(
              icon: Icon(Icons.location_city_outlined),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(CustomInfoWindowExample.routName);
              }),
          IconButton(
              icon: Icon(Icons.location_on),
              onPressed: () {
                Navigator.of(context).pushNamed(AllMarkers.routName);
              }),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaceProvider>(context, listen: false)
            .fetchAndSet(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaceProvider>(
                child: Text("No places yet!"),
                builder: (ctx, object, ch) => object.getItemsList.length <= 0
                    ? ch
                    : ListView.builder(
                        itemCount: object.getItemsList.length,
                        itemBuilder: (ctx, i) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(object.getItemsList[i].image),
                              ),
                              title: Text(object.getItemsList[i].title),
                              subtitle:
                                  Text(object.getItemsList[i].location.address),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    PlaceDetailScreen.routName,
                                    arguments: object.getItemsList[i].id);
                              },
                            )),
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:great_place_app/providers/great_places_provider.dart';
import 'package:great_place_app/screens/maps_screen.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routName = '/detail-screen';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<GreatPlaceProvider>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.blueGrey),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapsScreen(
                        initialPosition: selectedPlace.location,
                        isSelecting: false,
                      )));
            },
            child: Text(
              "View Location",
            ),
            textColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}

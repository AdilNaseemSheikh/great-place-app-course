import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_place_app/helpers/location_helper.dart';
import 'package:great_place_app/screens/maps_screen.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function pointerSelectPlace;

  LocationInput(this.pointerSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String imagePreviewUrl;

  void showPreview(lat, lng) {
    final staticMapUrl = LocationHelper.generateLocationPreviewImage(
        latitude: lat, longitude: lng);
    setState(() {
      imagePreviewUrl = staticMapUrl;
    });
  }

  Future<void> getUserCurrentLocation() async {
    final locationData = await Location().getLocation();

    showPreview(locationData.latitude, locationData.longitude);
    widget.pointerSelectPlace(locationData.latitude, locationData.longitude);
  }

  Future<void> selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      //push<LatLng> means that it will
      MaterialPageRoute(
        // return LatLng type of data when popped
        fullscreenDialog: true,
        builder: (cxt) => MapsScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    showPreview(selectedLocation.latitude, selectedLocation.latitude);
    widget.pointerSelectPlace(
        selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          height: 170,
          width: double.infinity,
          child: imagePreviewUrl == null
              ? Center(
                  child: Text(
                    "No location chosen",
                    textAlign: TextAlign.center,
                  ),
                )
              : Image.network(
                  imagePreviewUrl,
                  fit: BoxFit.cover,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              onPressed: getUserCurrentLocation,
              icon: Icon(Icons.location_on),
              label: Text("Use current location"),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: selectOnMap,
              icon: Icon(Icons.map),
              label: Text("Select location"),
              textColor: Theme.of(context).primaryColor,
            )
          ],
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_place_app/Models/place.dart';

class MapsScreen extends StatefulWidget {
  final PlaceLocation initialPosition;
  final bool isSelecting;

  MapsScreen(
      {this.initialPosition =
          const PlaceLocation(latitude: 37.422, longitude: -122.084),
      this.isSelecting = false});

  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  LatLng pickedLocation;

  //List<Marker> myMarkers = [];

  void selectLocation(LatLng position) {
    //myMarkers.add(Marker(markerId: MarkerId("markerId"),position: position));
    setState(() {
      pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
        actions: [
          if (widget.isSelecting)
            IconButton(
                onPressed: pickedLocation == null
                    ? null
                    : () {
                        //print("longitude is ${pickedLocation.longitude} and latitude is ${pickedLocation.latitude} before popping");
                        Navigator.of(context).pop(pickedLocation);
                      },
                icon: Icon(Icons.check))
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialPosition.latitude,
              widget.initialPosition.longitude),
          zoom: 16,
        ),

        onTap: widget.isSelecting ? selectLocation : null,

        //markers: Set.from(myMarkers),
        markers: (pickedLocation == null && widget.isSelecting)
            ? {}
            : {
                Marker(
                  markerId: MarkerId("m1"),
                  position: pickedLocation ??
                      LatLng(widget.initialPosition.latitude,
                          widget.initialPosition.longitude),
                ),
              },
      ),
    );
  }
}

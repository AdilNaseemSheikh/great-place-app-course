import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_place_app/providers/great_places_provider.dart';
import 'package:great_place_app/screens/location_detail.dart';
import 'package:provider/provider.dart';

class AllMarkers extends StatefulWidget {
  static const routName = '/all-markers';

  @override
  _AllMarkersState createState() => _AllMarkersState();
}

class _AllMarkersState extends State<AllMarkers> {
  final List<Marker> myMarkers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final myList =
        Provider.of<GreatPlaceProvider>(context, listen: false).getItemsList;
    for (int i = 0; i < myList.length; i++) {
      myMarkers.add(
        Marker(
          markerId: MarkerId("${DateTime.now()}"),
          position:
              LatLng(myList[i].location.latitude, myList[i].location.longitude),
          infoWindow: InfoWindow(
              title: "${myList[i].title}",
              snippet: "${myList[i].location.address}",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => LocationDetail(myList[i]),
                  ),
                );
              }),
        ),
      );
    }
  }

  // void fn() {
  //   for (int i = 0; i < myMarkers.length; i++) {
  //     print(
  //         "id = ${myMarkers[i].markerId} and marker = ${myMarkers[i].position}");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Markers"),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(72.7050929, 32.04846090000001), zoom: 16),
        markers: Set.from(myMarkers),
        myLocationEnabled: true,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_place_app/Models/place.dart';

class LocationDetail extends StatelessWidget {

  final Place myList;
  LocationDetail(this.myList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(myList.title),
      ),
      body: Column(children: [
        Text(myList.location.address),
      ],),
    );
  }
}

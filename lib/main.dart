import 'package:flutter/material.dart';
import 'package:great_place_app/providers/great_places_provider.dart';
import 'package:great_place_app/screens/add_place_screen.dart';
import 'package:great_place_app/screens/all_markers.dart';
import 'package:great_place_app/screens/custom_info.dart';
import 'package:great_place_app/screens/location_detail.dart';
import 'package:great_place_app/screens/place_detail_screen.dart';
import 'package:great_place_app/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaceProvider(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routName: (ctx) => AddPlaceScreen(),
          PlaceDetailScreen.routName: (ctx) => PlaceDetailScreen(),
          AllMarkers.routName: (ctx) => AllMarkers(),
          CustomInfoWindowExample.routName: (ctx) => CustomInfoWindowExample(),
          // LocationDetail.routName:(ctx)=>LocationDetail(),
        },
      ),
    );
  }
}

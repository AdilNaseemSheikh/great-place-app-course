import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:great_place_app/Models/place.dart';
import 'package:great_place_app/helpers/db_helpers.dart';
import 'package:great_place_app/helpers/location_helper.dart';

class GreatPlaceProvider with ChangeNotifier {
  List<Place> _itemsList = [];

  List<Place> get getItemsList {
    return [..._itemsList];
  }

  Place findById(String id){
    return _itemsList.firstWhere((element) => element.id==id);
  }

  Future<void> addPlace(
      String pickedTitle, File pickedImage, PlaceLocation loc) async {
    final add =
        await LocationHelper.getPlaceAddress(loc.latitude, loc.longitude);// add is address
    PlaceLocation locationWithAddress = PlaceLocation(
        latitude: loc.latitude, longitude: loc.longitude, address: add);
    final newPlace = Place(
        title: pickedTitle,
        image: pickedImage,
        id: DateTime.now().toString(),
        location: locationWithAddress);
    _itemsList.add(newPlace);
    notifyListeners();
    DBHelpers.insert('table1', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  Future<void> fetchAndSet() async {
    final dataList = await DBHelpers.getData('table1');
    _itemsList = dataList
        .map((e) => Place(
            id: e['id'],
            title: e['title'],
            image: File(e['image']),
            location: PlaceLocation(
                longitude: e['loc_lng'],
                latitude: e['loc_lat'],
                address: e['address'])))
        .toList();
    notifyListeners();
  }
}

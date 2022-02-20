import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_place_app/Models/place.dart';
import 'package:great_place_app/providers/great_places_provider.dart';
import 'package:great_place_app/widget/image_input.dart';
import 'package:great_place_app/widget/location_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routName = "/add-place";

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;
  PlaceLocation pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void selectPlace(double lat, double lng) {
    pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void savePlace() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        pickedLocation == null) {
      return;
    }
    Provider.of<GreatPlaceProvider>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage,pickedLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add place"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: "Title"),
                      controller: _titleController,
                    ),
                    SizedBox(height: 10),
                    ImageInput(_selectImage),
                    SizedBox(height: 10),
                    LocationInput(selectPlace),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
              color: Theme.of(context).accentColor,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              elevation: 0,
              onPressed: savePlace,
              icon: Icon(Icons.add),
              label: Text("Add Place")),
        ],
      ),
    );
  }
}

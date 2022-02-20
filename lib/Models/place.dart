import 'dart:io';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation({
    this.address,
    this.latitude,
    this.longitude,
  });
}

class Place {
  final String id;
  final String title;
  final PlaceLocation location;
  final File image;

  Place({this.title, this.id, this.image, this.location});
}

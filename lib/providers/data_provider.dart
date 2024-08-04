import 'package:shopping_app_jhonny_mustafa/models/favorite_place.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  //final List<FavoritePlaceItem> _favPlaceItem = [];
  final _favPlaceItem = FavoritePlaceItem(
      name: 'name', image: 'image', location: 'location', lat: 0.0, lng: 0.0);

  FavoritePlaceItem get favPlaceItem => _favPlaceItem;

  void addPlace(FavoritePlaceItem item) {
    // _favPlaceItem.add(
    //   FavoritePlaceItem(
    //     name: item.name,
    //     image: item.image,
    //     location: item.location,
    //     lat: item.lat,
    //     lng: item.lng,
    //   ),
    //);

    _favPlaceItem.name = item.name;
    _favPlaceItem.image = item.image;
    _favPlaceItem.location = item.location;
    _favPlaceItem.lat = item.lat;
    _favPlaceItem.lng = item.lng;

    notifyListeners();
  }
}

import 'dart:io';
import 'package:flutter/foundation.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class BeautifulPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id){
    return _items.firstWhere((place) => place.id == id);
  }

  Future<void> addPlace(
      String title, File image, PlaceLocation location) async {
    final address = await LocationHelper.getPlaceAddress(
        latitude: location.latitude, longitude: location.longitude);
    final updatedLocation = PlaceLocation(
        latitude: location.latitude,
        longitude: location.longitude,
        address: address);
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        location: updatedLocation,
        image: image);
    _items.add(newPlace);
    notifyListeners();
    DbHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DbHelper.getData('user_places');
    _items = dataList
        .map((item) => Place(
            id: item['id'],
            title: item['title'],
            location: PlaceLocation(
                latitude: item['loc_lat'],
                longitude: item['loc_lng'],
                address: item['address']),
            image: File(item['image'])))
        .toList();
    print("hiii");
    print(_items[0]);
    notifyListeners();
  }
}

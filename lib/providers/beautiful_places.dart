import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../models/place.dart';

class BeautifulPlaces with ChangeNotifier {
  
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }
  
}
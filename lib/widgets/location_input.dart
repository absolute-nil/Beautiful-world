import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  Future<void> _getUserLocation() async {
    final locData = await Location().getLocation();
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: locData.latitude, longitude: locData.longitude);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
        builder: (ctx) => MapScreen(
              isSelecting: true,
            )));
    if(selectedLocation == null){
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: double.infinity,
            height: 170,
            decoration: BoxDecoration(
                border:
                    Border.all(width: 1, color: Theme.of(context).accentColor)),
            child: _previewImageUrl == null
                ? Center(child: Icon(Icons.image))
                : Image.network(
                    _previewImageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
                onPressed: _getUserLocation,
                icon: Icon(Icons.location_searching),
                textColor: Theme.of(context).primaryColor,
                label: Text('current location')),
            FlatButton.icon(
                onPressed: _selectOnMap,
                icon: Icon(Icons.map),
                label: Text("Pick Location"))
          ],
        )
      ],
    );
  }
}

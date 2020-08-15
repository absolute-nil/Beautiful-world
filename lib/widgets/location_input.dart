import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onLocationSelect;
  LocationInput(this.onLocationSelect);
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;
  var _loading = false;
  void _showMapPreview(double lat, double lng) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: lat, longitude: lng);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
      _loading = false;
    });
  }

  Future<void> _getUserLocation() async {
    try {
      setState(() {
        _loading = true;
      });
      final locData = await Location().getLocation();
      _showMapPreview(locData.latitude, locData.longitude);
      widget.onLocationSelect(locData.latitude, locData.longitude);
    } catch (e) {
      setState(() {
        _loading = false;
      });
      return;
    }
  }

  Future<void> _selectOnMap() async {
    setState(() {
      _loading = true;
    });
    final selectedLocation =
        await Navigator.of(context).push<LatLng>(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (ctx) => MapScreen(
                  isSelecting: true,
                )));
    if (selectedLocation == null) {
      return;
    }
    _showMapPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onLocationSelect(
        selectedLocation.latitude, selectedLocation.longitude);
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
            child: (_previewImageUrl == null && !_loading)
                ? Center(child: Text("Select location"))
                : _loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
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

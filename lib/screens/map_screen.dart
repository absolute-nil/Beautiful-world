import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  const MapScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: 19.076090, longitude: 72.877426),
      this.isSelecting = false});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your map"),
      ),
      body: GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(widget.initialLocation.latitude,
                  widget.initialLocation.longitude),
                  zoom: 16)),
    );
  }
}

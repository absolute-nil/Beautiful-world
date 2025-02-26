import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/beautiful_places.dart';
import './map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {

  static const route_name = "/place-detail";

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<BeautifulPlaces>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                fullscreenDialog: true,
                  builder: (ctx) => MapScreen(
                        initialLocation: selectedPlace.location,
                        isSelecting: false,
                      )));
            },
            child: Text("View On Map"),
            textColor: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import '../providers/beautiful_places.dart';
import './place_detail_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your places"),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).pushNamed(AddPlaceScreen.route_name);
                })
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<BeautifulPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<BeautifulPlaces>(
                      builder: (ctx, beautifulPlaces, child) =>
                          beautifulPlaces.items.length <= 0
                              ? child
                              : Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: ListView.builder(
                                    itemBuilder: (ctx, i) => ListTile(
                                      leading: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: FileImage(
                                            beautifulPlaces.items[i].image),
                                      ),
                                      title: Text(
                                        beautifulPlaces.items[i].title
                                            .toUpperCase(),
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      subtitle: Text(
                                        beautifulPlaces.items[i].location.address,
                                        style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic , color: Theme.of(context).accentColor)),
                                      onTap: () {
                                        Navigator.of(context).pushNamed(PlaceDetailScreen.route_name,
                                        arguments: beautifulPlaces.items[i].id);
                                      },
                                    ),
                                    itemCount: beautifulPlaces.items.length,
                                  ),
                                ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("No places to show yet"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Add Place"),
                              IconButton(
                                icon: Icon(Icons.add_box),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(AddPlaceScreen.route_name);
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
        ));
  }
}

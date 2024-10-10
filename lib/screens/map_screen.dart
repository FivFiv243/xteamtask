import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:pretty_animated_buttons/pretty_animated_buttons.dart';
import 'package:xteamtask/bloc/app_bloc/app_bloc.dart';
import 'package:xteamtask/fetures/map_logic/location_caller.dart';
import 'package:xteamtask/fetures/map_logic/marker_class.dart';
import 'package:xteamtask/firebase_things/firebase_storages.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

final _mapController = MapController();
final _nameController = TextEditingController();
final _discriptionController = TextEditingController();
final _AppBloc = AppBloc();
late Stream dotStream;
late LocationData _currentPosition;

Future _getLoc() async {
  _currentPosition = LocationData.fromMap(Map());
  _currentPosition = await fetchLocation();
}

Future _getMapDots() async {
  dotStream = Stream.empty();
  dotStream = await FireStorages().getPoints();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    // TODO: implement initState
    _getLoc().whenComplete(() {
      setState(() {});
    });
    _getMapDots().whenComplete(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final QueryWidth = MediaQuery.of(context).size.width;
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        onTap: (tapPosition, point) {
          showDialog(
              context: context,
              builder: (BuildContext context3) {
                return AlertDialog(
                  content: Column(
                    children: [
                      Container(
                        width: QueryWidth / 1.15,
                        child: TextField(
                          style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                          decoration: InputDecoration(
                            labelText: 'name of point',
                            labelStyle: TextStyle(color: Colors.black87),
                            border: UnderlineInputBorder(),
                            disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey, width: 1, style: BorderStyle.solid)),
                          ),
                          controller: _nameController,
                          maxLength: 32,
                          onChanged: (value) => _nameController.text,
                        ),
                      ),
                      Container(
                        width: QueryWidth / 1.15,
                        child: TextField(
                          style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                          decoration: InputDecoration(
                            labelText: 'description',
                            labelStyle: TextStyle(color: Colors.black87),
                            border: UnderlineInputBorder(),
                            disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: Colors.grey, width: 1, style: BorderStyle.solid)),
                          ),
                          minLines: 1,
                          maxLines: 10,
                          controller: _discriptionController,
                          maxLength: 256,
                          onChanged: (value) => _discriptionController.text,
                        ),
                      ),
                      Spacer(),
                      PrettyWaveButton(
                        child: const Text(
                          'Add marker',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context3, rootNavigator: true).pop('dialog');
                          _AppBloc.add(AddNewPointEvent(NewMapMarker: MarkerMapClass(name: _nameController.text.trim(), description: _discriptionController.text.trim(), Lat: point.latitude, Lng: point.longitude)));
                          _nameController.clear();
                          _discriptionController.clear();
                        },
                      ),
                    ],
                  ),
                );
              });
        },
        minZoom: 3,
        maxZoom: 17.5,
        initialCenter: LatLng(55.755793, 37.617134),
        initialZoom: 5,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.xteamtask',
        ),
        StreamBuilder(
            stream: dotStream,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? MarkerLayer(
                      markers: snapshot.data.docs.length > 0
                          ? List.generate(_currentPosition == LocationData.fromMap(Map()) ? snapshot.data.docs.length : snapshot.data.docs.length + 1, (index) {
                              if (index < snapshot.data.docs.length) {
                                var Mark = snapshot.data.docs[index];
                                return Marker(
                                    point: LatLng(Mark['lat'], Mark['lng']),
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context2) {
                                              return AlertDialog(
                                                  content: Column(children: [
                                                Text(
                                                  Mark['name'],
                                                  maxLines: 4,
                                                ),
                                                Text(
                                                  Mark['description'],
                                                  maxLines: 12,
                                                ),
                                                Spacer(),
                                                PrettyWaveButton(
                                                  child: const Text(
                                                    'delete',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    snapshot.data.docs[index].reference.delete();
                                                    Navigator.of(context2, rootNavigator: true).pop('dialog');
                                                  },
                                                ),
                                              ]));
                                            });
                                      },
                                      child: Image.asset(
                                        'lib/assets/image/clipart3004129.png',
                                        width: 100,
                                        height: 100,
                                        alignment: Alignment.center,
                                      ),
                                    ));
                              } else {
                                return Marker(point: LatLng(_currentPosition.latitude != null ? _currentPosition.latitude! : 0.0, _currentPosition.latitude != null ? _currentPosition.longitude! : 0), child: InkWell(onTap: () {}, child: Icon(Icons.man)));
                              }
                            })
                          : [])
                  : MarkerLayer(
                      markers: [],
                    );
            })
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rapidoc_maps_plugin/lang/Langs.dart';

final LatLng coordinates = LatLng(0, 0);

class Maps extends StatefulWidget {
  final Function(LatLng?)? onPlaceSelected;
  final LatLng? initialPosition;
  final double? zoom;
  final Set<Polyline>? polylines;
  final Set<Polygon>? polygons;
  final Set<Marker>? markers;
  final Set<Circle>? circles;
  final CameraTargetBounds? cameraTargetBounds;
  final Function(LatLng)? onTap;
  final bool myLocationEnabled;
  final bool myLocationButtonEnabled;

  Maps({
    Key? key,
    this.onPlaceSelected,
    this.initialPosition,
    this.polylines,
    this.polygons,
    this.markers,
    this.circles,
    this.onTap,
    this.cameraTargetBounds,
    this.zoom,
    this.myLocationEnabled: false,
    this.myLocationButtonEnabled: false,
  }) : super(key: key);

  @override
  MapsState createState() => MapsState();
}

class MapsState extends State<Maps> {
  GoogleMapController? controller;

  late double zoom;

  MapType mapType = MapType.normal;
  late LatLng center;

  @override
  void initState() {
    center = widget.initialPosition ?? LatLng(0, 0);

    zoom = widget.zoom ?? 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lang = appLocalizationsWrapper.lang;
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        GoogleMap(
          zoomControlsEnabled: false,
          zoomGesturesEnabled: true,
          onMapCreated: (controller) async {
            this.controller = controller;
          },
          onCameraIdle: () {},
          initialCameraPosition:
              CameraPosition(target: LatLng(center.latitude, center.longitude), zoom: zoom),
          mapType: mapType,
          onCameraMove: (CameraPosition position) {
            center = LatLng(position.target.latitude, position.target.longitude);
          },
          markers: widget.markers ?? Set.of([]),
          polygons: widget.polygons ?? Set.of([]),
          polylines: widget.polylines ?? Set.of([]),
          circles: widget.circles ?? Set.of([]),
          onTap: widget.onTap,
          cameraTargetBounds: widget.cameraTargetBounds ?? CameraTargetBounds.unbounded,
          myLocationEnabled: widget.myLocationEnabled,
          myLocationButtonEnabled: widget.myLocationButtonEnabled,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  SizedBox(width: 10),
                  Container(
                    color: Colors.white,
                    height: 50,
                    width: 50,
                    child: PopupMenuButton<MapType>(
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                          value: MapType.normal,
                          child: Text(
                            lang.mapNormal,
                          ),
                        ),
                        PopupMenuItem(
                          value: MapType.terrain,
                          child: Text(
                            lang.mapTerrain,
                          ),
                        ),
                        PopupMenuItem(
                          value: MapType.hybrid,
                          child: Text(
                            lang.mapHybrid,
                          ),
                        ),
                        PopupMenuItem(
                          value: MapType.satellite,
                          child: Text(
                            lang.mapSatellite,
                          ),
                        ),
                      ],
                      child: Icon(Icons.more_horiz),
                      onSelected: (type) => setState(() {
                        mapType = type;
                      }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 30, right: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.zoom_out),
                        onPressed: () {
                          setState(() {
                            zoom++;
                            controller?..animateCamera(CameraUpdate.zoomOut());
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.zoom_in),
                        onPressed: () {
                          setState(() {
                            zoom--;
                            controller?..animateCamera(CameraUpdate.zoomIn());
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.gps_fixed),
                        onPressed: () async {
                          try {
                            var position = await Geolocator.getCurrentPosition(
                              desiredAccuracy: LocationAccuracy.medium,
                              timeLimit: Duration(
                                seconds: 7,
                              ),
                            );

                            controller
                              ?..animateCamera(CameraUpdate.newLatLng(
                                  LatLng(position.latitude, position.longitude)));
                          } catch (error) {
                            print("Could not get location! $error");
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

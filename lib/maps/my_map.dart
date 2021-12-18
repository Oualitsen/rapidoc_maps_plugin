import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rapidoc_maps_plugin/lang/langs.dart';

class Maps extends StatefulWidget {
  final LatLng? initialPosition;
  final double zoom;
  final List<Marker>? markers;
  final List<Polyline>? polylines;
  final List<Polygon>? polygons;
  final List<Circle>? circles;
  final CameraTargetBounds? cameraTargetBounds;
  final Function(LatLng)? onTap;
  final bool myLocationEnabled;
  final bool myLocationButtonEnabled;
  final Function()? onMapsReady;
  final String langName;

  Maps({
    Key? key,
    this.initialPosition,
    this.polylines,
    this.polygons,
    this.markers,
    this.circles,
    this.onTap,
    this.cameraTargetBounds,
    this.zoom: 0,
    this.myLocationEnabled: false,
    this.myLocationButtonEnabled: false,
    this.onMapsReady,
    this.langName = "en",
  }) : super(key: key);

  @override
  MapsState createState() => MapsState();
}

class MapsState extends State<Maps> {
  final Completer<GoogleMapController> _controller = Completer();

  MapType mapType = MapType.normal;
  late LatLng center;
  late final Lang lang;
  bool _mapsReady = false;

  @override
  void initState() {
    lang = findLangByName(widget.langName);
    center = widget.initialPosition ?? LatLng(0, 0);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.future.then((value) => value.dispose());
  }

  Future<double> getZoomLevel() async {
    var ctrl = await _controller.future;
    return ctrl.getZoomLevel();
  }

  Future<void> animateCamera(CameraUpdate cameraUpdate) async {
    var ctrl = await _controller.future;
    return ctrl.animateCamera(cameraUpdate);
  }

  Future<void> moveCamera(CameraUpdate cameraUpdate) async {
    var ctrl = await _controller.future;
    return ctrl.moveCamera(cameraUpdate);
  }

  Future<LatLng> getLatLng(ScreenCoordinate screenCoordinate) async {
    var ctrl = await _controller.future;
    return ctrl.getLatLng(screenCoordinate);
  }

  Future<LatLngBounds> getVisibleRegion() async {
    var ctrl = await _controller.future;
    return ctrl.getVisibleRegion();
  }

  Future<void> hideMarkerInfoWindow(String markerId) async {
    var ctrl = await _controller.future;
    return ctrl.hideMarkerInfoWindow(MarkerId(markerId));
  }

  Future<bool> isMarkerInfoWindowShown(String markerId) async {
    var ctrl = await _controller.future;
    return ctrl.isMarkerInfoWindowShown(MarkerId(markerId));
  }

  Future<void> showMarkerInfoWindow(String markerId) async {
    var ctrl = await _controller.future;
    return ctrl.showMarkerInfoWindow(MarkerId(markerId));
  }

  static LatLngBounds createBounds(LatLng southwest, LatLng northeast) {
    final points = [southwest, northeast];

    final highestLat = points.map((e) => e.latitude).reduce(max);
    final highestLong = points.map((e) => e.longitude).reduce(max);
    final lowestLat = points.map((e) => e.latitude).reduce(min);
    final lowestLong = points.map((e) => e.longitude).reduce(min);

    final lowestLatLowestLong = LatLng(lowestLat, lowestLong);
    final highestLatHighestLong = LatLng(highestLat, highestLong);

    return LatLngBounds(
        southwest: lowestLatLowestLong, northeast: highestLatHighestLong);
  }

  bool get isMapsReady => _mapsReady;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        GoogleMap(
          zoomControlsEnabled: false,
          zoomGesturesEnabled: true,
          onMapCreated: (controller) async {
            _controller.complete(controller);
            _mapsReady = true;
            if (widget.onMapsReady != null) {
              widget.onMapsReady!();
            }
          },
          onCameraIdle: () {},
          initialCameraPosition: CameraPosition(
              target: LatLng(center.latitude, center.longitude),
              zoom: widget.zoom),
          mapType: mapType,
          onCameraMove: (CameraPosition position) {
            center =
                LatLng(position.target.latitude, position.target.longitude);
          },
          markers: Set.of(widget.markers ?? []),
          polygons: Set.of(widget.polygons ?? []),
          polylines: Set.of(widget.polylines ?? []),
          circles: Set.of(widget.circles ?? []),
          onTap: widget.onTap,
          cameraTargetBounds:
              widget.cameraTargetBounds ?? CameraTargetBounds.unbounded,
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
                      onSelected: (type) {
                        setState(() {
                          mapType = type;
                        });
                      },
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
                        onPressed: () async {
                          var ctrl = await _controller.future;

                          setState(() {
                            ctrl.animateCamera(CameraUpdate.zoomOut());
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.zoom_in),
                        onPressed: () async {
                          var ctrl = await _controller.future;
                          setState(() {
                            ctrl.animateCamera(CameraUpdate.zoomIn());
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
                            var ctrl = await _controller.future;
                            ctrl.animateCamera(CameraUpdate.newLatLng(
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

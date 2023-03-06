import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rapidoc_maps_plugin/lang/langs.dart';
import 'package:rxdart/rxdart.dart';

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
  final void Function()? onCameraIdle;
  final void Function()? onCameraMoveStarted;
  final void Function(CameraPosition position)? onCameraMove;
  final bool showZoomIn;
  final bool showZoomOut;
  final bool showCurrentPosition;

  const Maps({
    Key? key,
    this.initialPosition,
    this.polylines,
    this.polygons,
    this.markers,
    this.circles,
    this.onTap,
    this.cameraTargetBounds,
    this.zoom = 0,
    this.myLocationEnabled = false,
    this.myLocationButtonEnabled = false,
    this.onMapsReady,
    this.langName = "en",
    this.onCameraIdle,
    this.onCameraMoveStarted,
    this.onCameraMove,
    this.showZoomIn = true,
    this.showZoomOut = true,
    this.showCurrentPosition = true,
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
    center = widget.initialPosition ?? const LatLng(0, 0);
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
          onCameraIdle: () {
            if (widget.onCameraIdle != null) {
              widget.onCameraIdle!();
            }
          },
          onCameraMoveStarted: () {
            if (widget.onCameraMoveStarted != null) {
              widget.onCameraMoveStarted!();
            }
          },
          initialCameraPosition: CameraPosition(
              target: LatLng(center.latitude, center.longitude),
              zoom: widget.zoom),
          mapType: mapType,
          onCameraMove: (CameraPosition position) {
            center =
                LatLng(position.target.latitude, position.target.longitude);
            if (widget.onCameraMove != null) {
              widget.onCameraMove!(position);
            }
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
              const SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  const SizedBox(width: 10),
                  Container(
                    color: Theme.of(context).cardColor,
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
                      child: const Icon(Icons.more_horiz),
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
                if (widget.showZoomOut ||
                    widget.showZoomIn ||
                    widget.showCurrentPosition)
                  Container(
                    color: Theme.of(context).cardColor,
                    child: Column(
                      children: <Widget>[
                        if (widget.showZoomOut)
                          IconButton(
                            icon: const Icon(Icons.zoom_out),
                            onPressed: () async {
                              var ctrl = await _controller.future;
                              setState(() {
                                ctrl.animateCamera(CameraUpdate.zoomOut());
                              });
                            },
                          ),
                        if (widget.showZoomIn)
                          IconButton(
                            icon: const Icon(Icons.zoom_in),
                            onPressed: () async {
                              var ctrl = await _controller.future;
                              setState(() {
                                ctrl.animateCamera(CameraUpdate.zoomIn());
                              });
                            },
                          ),
                        if (widget.showCurrentPosition)
                          IconButton(
                            icon: const Icon(Icons.gps_fixed),
                            onPressed: () async {
                              Rx.zip([
                                Geolocator.getCurrentPosition(
                                  desiredAccuracy: LocationAccuracy.medium,
                                  timeLimit: const Duration(seconds: 7),
                                ).asStream(),
                                _controller.future.asStream(),
                              ], (values) => values).listen((values) {
                                var position = values[0] as Position;
                                var ctrl = values[1] as GoogleMapController;
                                ctrl.animateCamera(CameraUpdate.newLatLng(
                                    LatLng(position.latitude,
                                        position.longitude)));
                              });
                            },
                          ),
                      ],
                    ),
                  ),
                const SizedBox(width: 10)
              ],
            ),
          ),
        ),
      ],
    );
  }

  Completer<GoogleMapController> get controller => _controller;
}

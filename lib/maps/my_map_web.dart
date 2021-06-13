import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rapidoc_maps_plugin/lang/Langs.dart';
import 'package:google_maps/google_maps.dart' as maps;
import 'dart:ui' as ui;
import 'package:universal_html/html.dart' as html;
import 'dart:math' as math;

class Maps extends StatefulWidget {
  final bool myLocationEnabled;
  final bool myLocationButtonEnabled;
  final LatLng? initialPosition;
  final double zoom;
  final Function(LatLng latLng)? onTap;
  final List<Marker>? markers;
  final List<Polyline>? polylines;
  final List<Polygon>? polygons;
  final List<Circle>? circles;
  final CameraTargetBounds? cameraTargetBounds;
  Maps({
    Key? key,
    this.initialPosition,
    this.zoom: 0,
    this.myLocationButtonEnabled: false,
    this.myLocationEnabled: false,
    this.markers,
    this.onTap,
    this.polylines,
    this.cameraTargetBounds,
    this.circles,
    this.polygons,
  }) : super(key: key);

  @override
  MapsState createState() => MapsState();
}

class MapsState extends State<Maps> {
  static String htmlId = "_rapidoc_google_maps";

  late double zoom;
  maps.MapTypeId mapType = maps.MapTypeId.TERRAIN;

  bool idled = false;

  var idleListener;

  late LatLng center;

  bool _registered = false;
  late maps.GMap map;

  final Map<String, maps.Marker> _markers = {};
  final Map<String, maps.Polyline> _polylines = {};
  final Map<String, maps.Polygon> _polygones = {};
  final Map<String, maps.Circle> _circles = {};
  final Map<String, _InfoWindowWrapper> _infoWindows = {};

  final lang = appLocalizationsWrapper.lang;
  final List<StreamSubscription> _subs = [];

  @override
  void initState() {
    center = widget.initialPosition ?? LatLng(0, 0);
    zoom = widget.zoom;
    if (widget.markers != null) {
      var __markers = _translate(widget.markers!);

      __markers.keys.forEach((element) {
        _markers[element] = __markers[element]!;
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _subs.forEach((element) {
      element.cancel();
    });
    _subs.clear();
    super.dispose();
  }

  Widget getMap() {
    if (!_registered) {
      // ignore: undefined_prefixed_name
      ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
        final mapOptions = maps.MapOptions()
          ..zoom = widget.zoom
          ..center = maps.LatLng(center.latitude, center.longitude)
          ..mapTypeControl = true
          ..zoomControl = true
          ..scaleControl = true
          ..fullscreenControl = false;
        final elem = html.DivElement()
          ..id = htmlId
          ..style.width = "100%"
          ..style.height = "100%"
          ..style.border = 'none';

        map = maps.GMap(elem, mapOptions);
        if (widget.onTap != null) {
          map.addListener("click", (e) {
            widget.onTap!(LatLng(e.latLng.lat(), e.latLng.lng()));
          });
        }
        map.addListener('idle', () {
          _showMarkers();
        });

        return elem;
      });
      _registered = true;
    }

    return HtmlElementView(viewType: htmlId);
  }

  void _showMarkers() {
    var newMarkers = _translate(widget.markers ?? []);

    /**
     * remove old markers
     */
    _markers.keys.forEach((key) {
      var _marker = _markers[key];
      if (_marker != null) {
        _marker.map = null;
      }
    });
    _markers.clear();
    newMarkers.keys.forEach((key) {
      var marker = newMarkers[key];
      if (marker != null) {
        marker.map = map;
      }
    });
    _markers.addAll(newMarkers);
  }

  void _showPolylines() {
    var newData = _translatePoylines(widget.polylines ?? []);
    _polylines.keys.forEach((key) {
      var poly = _polylines[key];
      if (poly != null) {
        poly.map = null;
      }
    });
    _polylines.clear();
    newData.keys.forEach((key) {
      var poly = newData[key];
      if (poly != null) {
        poly.map = map;
      }
    });
    _polylines.addAll(newData);
  }

  void _showPolygones() {
    var newData = _translatePoygones(widget.polygons ?? []);
    _polygones.keys.forEach((key) {
      var poly = _polygones[key];
      if (poly != null) {
        poly.map = null;
      }
    });
    _polygones.clear();
    newData.keys.forEach((key) {
      var poly = newData[key];
      if (poly != null) {
        poly.map = map;
      }
    });
    _polygones.addAll(newData);
  }

  void _showCircles() {
    var newData = _translateCircles(widget.circles ?? []);
    _circles.keys.forEach((key) {
      var poly = _circles[key];
      if (poly != null) {
        poly.map = null;
      }
    });
    _circles.clear();
    newData.keys.forEach((key) {
      var c = newData[key];
      if (c != null) {
        c.map = map;
      } else {}
    });
    _circles.addAll(newData);
    print("_circles.map = ${_circles.length}");
  }

  void _showComponents() {
    if (!_registered) {
      return;
    }
    _showMarkers();
    _showPolylines();
    _showPolygones();
    _showCircles();
  }

  @override
  Widget build(BuildContext context) {
    _showComponents();
    return getMap();
  }

  Map<String, maps.Marker> _translate(List<Marker> markers) {
    final Map<String, maps.Marker> _markersMap = {};
    markers.forEach((m) {
      //marker.

      var _marker = maps.Marker()
        ..position = maps.LatLng(m.position.latitude, m.position.longitude)
        ..visible = m.visible
        ..draggable = m.draggable;

      final nativeIcon = m.icon;

      var _json = nativeIcon.toJson() as List;
      print("nativeIcon = ${nativeIcon.toJson()}");

      final action = _json[0] as String;

      switch (action) {
        case 'fromAssetImage':
          _marker.icon = _json[1] as String;
          break;
        case 'fromBytes':
          /**
         * Not supported!
         */
          break;
        case 'defaultMarker':
        /**
         * Default marker
         */
      }

      if (m.onTap != null) {
        _marker.clickable = true;
        _subs.add(
          _marker.onClick.listen((event) {
            m.onTap!();
          }),
        );
      }

      /**
       * Dragable
       */
      if (m.onDragEnd != null) {
        _marker.onDragend.listen((event) {
          var _ll = event.latLng!;
          m.onDragEnd!(LatLng(_ll.lat.toDouble(), _ll.lng.toDouble()));
        });
      }

      /**
       * Info window
       */

      _infoWindows.keys.forEach((key) {
        /**
         *
         */
        var iw = _infoWindows[key];
        if (iw != null) {}
      });

      if (m.infoWindow != InfoWindow.noText) {
        var _iw = m.infoWindow;
        final options = maps.InfoWindowOptions()
          ..position = _marker.position
          ..content = _iw.title ?? _iw.snippet;
        maps.InfoWindow iw = maps.InfoWindow()..options = options;
        _subs.add(
          _marker.onClick.listen(
            (event) {
              iw.open(map, _marker);
              var iww = _infoWindows[m.markerId.value];
              if (iww != null) {
                iww.open = true;
              }
            },
          ),
        );

        _infoWindows[m.markerId.value] = _InfoWindowWrapper(iw);
        iw.onCloseclick.listen((event) {
          var iww = _infoWindows[m.markerId.value];
          if (iww != null) {
            iww.open = false;
          }
        });
      }

      _markersMap[m.markerId.value] = _marker;
    });
    return _markersMap;
  }

  Map<String, maps.Polyline> _translatePoylines(List<Polyline> polylines) {
    final Map<String, maps.Polyline> _polylineMap = {};
    polylines.forEach((p) {
      final _options = maps.PolylineOptions();

      _options.zIndex = p.zIndex;
      _options.clickable = p.onTap != null;
      _options.draggable = false;
      _options.visible = p.visible;
      _options.strokeWeight = p.width;
      _options.strokeOpacity = p.color.opacity;
      _options.strokeColor = getHash(p.color);
      _options.path = p.points.map((e) => maps.LatLng(e.latitude, e.longitude)).toList();
      _options.geodesic = p.geodesic;

      var polyline = maps.Polyline()..options = _options;
      if (p.onTap != null) {
        _subs.add(polyline.onClick.listen((event) {
          p.onTap!();
        }));
      }

      _polylineMap[p.polylineId.value] = polyline;
    });
    return _polylineMap;
  }

  Map<String, maps.Polygon> _translatePoygones(List<Polygon> polylines) {
    final Map<String, maps.Polygon> _polylineMap = {};
    polylines.forEach((p) {
      final _options = maps.PolygonOptions();

      _options.zIndex = p.zIndex;
      _options.clickable = p.onTap != null;
      _options.visible = p.visible;
      _options.draggable = false;
      _options.visible = true;
      _options.geodesic = p.geodesic;
      _options.strokeWeight = p.strokeWidth;
      _options.strokeOpacity = p.strokeColor.opacity;
      _options.strokeColor = getHash(p.strokeColor);

      _options.fillColor = getHash(p.fillColor);
      _options.fillOpacity = p.fillColor.opacity;

      final _paths = [
        p.points.map((e) => maps.LatLng(e.latitude, e.longitude)).toList(),
      ];

      p.holes.forEach((hole) {
        _paths.add(hole.map((e) => maps.LatLng(e.latitude, e.longitude)).toList());
      });

      _options.paths = _paths;

      var polyline = maps.Polygon()..options = _options;
      if (p.onTap != null) {
        _subs.add(polyline.onClick.listen((event) {
          p.onTap!();
        }));
      }

      _polylineMap[p.polygonId.value] = polyline;
    });
    return _polylineMap;
  }

  String getHash(Color c) {
    var hash = c.value.toRadixString(16);
    if (hash == "0") {
      hash = "00000000";
    }
    var _hash = hash.substring(2);
    return "#$_hash";
  }

  Map<String, maps.Circle> _translateCircles(List<Circle> circles) {
    final Map<String, maps.Circle> _circleMap = {};
    circles.forEach((c) {
      final _options = maps.CircleOptions();

      _options.zIndex = c.zIndex;
      _options.clickable = c.onTap != null;
      _options.visible = c.visible;
      _options.draggable = false;
      _options.visible = true;
      _options.strokeWeight = c.strokeWidth;
      _options.strokeOpacity = c.strokeColor.opacity;
      _options.strokeColor = getHash(c.strokeColor);

      _options.fillColor = getHash(c.fillColor);
      _options.fillOpacity = c.fillColor.opacity;
      _options.center = maps.LatLng(c.center.latitude, c.center.longitude);
      _options.radius = c.radius;

      var polyline = maps.Circle()..options = _options;
      if (c.onTap != null) {
        _subs.add(polyline.onClick.listen((event) {
          c.onTap!();
        }));
      }
      _circleMap[c.circleId.value] = polyline;
    });
    return _circleMap;
  }

  Future<void> animateCamera(CameraUpdate cameraUpdate) async {
    return _handleCameraUpdate(cameraUpdate, true);
  }

  Future<void> _handleCameraUpdate(CameraUpdate cameraUpdate, bool animate) async {
    List<Object> _list = cameraUpdate.toJson() as List<Object>;

    final action = _list[0] as String;
    switch (action) {
      case 'zoomIn':
        map.zoom = (map.zoom ?? 0) + 1;
        break;
      case 'zoomOut':
        map.zoom = (map.zoom ?? 0) - 1;
        break;
      case 'zoomTo':
        map.zoom = (_list[1] as int);
        break;
      case 'zoomBy':
        final currentZoom = map.zoom ?? 0.0;
        final zoom = _list[1] as double;

        map.zoom = currentZoom + zoom;

        if (_list.length == 3) {
          /**
           * @TODO
           * Handle offeset here
           */
        }

        break;
      case 'newLatLng':
        final coords = _list[1] as List<double>;
        var _latLng = maps.LatLng(coords[0], coords[1]);
        if (animate) {
          map.panTo(_latLng);
        } else {
          map.center = _latLng;
        }
        break;
      case 'newLatLngZoom':
        final _zoom = _list[2] as int;
        final coords = _list[1] as List<double>;
        var _latLng = maps.LatLng(coords[0], coords[1]);

        if (animate) {
          map.panTo(_latLng);
          map.zoom = _zoom;
        } else {
          map.center = _latLng;
          map.zoom = _zoom;
        }
        break;
      case 'newLatLngBounds':
        var list = _list[1] as List<Object>;
        print(list.runtimeType);
        var sw = list[0] as List<double>;
        var ne = list[1] as List<double>;

        var bounds = maps.LatLngBounds(
          maps.LatLng(sw[0], sw[1]),
          maps.LatLng(ne[0], ne[1]),
        );
        var padding = _list[2] as double;

        if (animate) {
          map.panToBounds(bounds, padding);
        } else {
          map.fitBounds(bounds, padding);
        }

        break;
      case "newCameraPosition":
        final conf = _list[1] as Map<String, dynamic>;
        final tilt = conf['tilt'] as double;
        final zoom = conf['zoom'] as double;
        final bearing = conf['bearing'] as double;
        final _target = conf['target'] as List<double>;
        final target = maps.LatLng(_target[0], _target[1]);
        if (animate) {
          map.panTo(target);
        } else {
          map.center = target;
        }
        map.zoom = zoom;
        map.tilt = tilt;
        map.heading = bearing;
    }
  }

  Future<void> moveCamera(CameraUpdate cameraUpdate) async {
    await _handleCameraUpdate(cameraUpdate, false);
  }

  Future<LatLng> getLatLng(ScreenCoordinate screenCoordinate) async {
    var latLng = _point2LatLng(screenCoordinate);
    return LatLng(latLng.lat.toDouble(), latLng.lng.toDouble());
  }

  _latLng2Point(maps.LatLng latLng) {
    maps.LatLngBounds bounds = map.bounds!;
    maps.Projection projection = map.projection!;

    var topRight = projection.fromLatLngToPoint!(bounds.northEast)!;

    var bottomLeft = projection.fromLatLngToPoint!(bounds.southWest)!;
    var scale = math.pow(2, map.zoom ?? 0);
    var worldPoint = projection.fromLatLngToPoint!(latLng)!;
    return ScreenCoordinate(
      x: ((worldPoint.x! - bottomLeft.x!) * scale).toInt(),
      y: ((worldPoint.y! - topRight.y!) * scale).toInt(),
    );
  }

  maps.LatLng _point2LatLng(ScreenCoordinate point) {
    maps.LatLngBounds bounds = map.bounds!;
    maps.Projection projection = map.projection!;
    var topRight = projection.fromLatLngToPoint!(bounds.northEast)!;
    var bottomLeft = projection.fromLatLngToPoint!(bounds.southWest)!;
    var scale = math.pow(2, map.zoom ?? 0);
    var worldPoint = maps.Point(point.x / scale + bottomLeft.x!, point.y / scale + topRight.y!);
    return projection.fromPointToLatLng!(worldPoint)!;
  }

  Future<LatLngBounds> getVisibleRegion() async {
    final maps.LatLngBounds bounds = map.bounds!;

    var result = LatLngBounds(
        southwest: LatLng(bounds.southWest.lat.toDouble(), bounds.southWest.lng.toDouble()),
        northeast: LatLng(bounds.northEast.lat.toDouble(), bounds.northEast.lng.toDouble()));
    return result;
  }

  Future<void> hideMarkerInfoWindow(String markerId) async {
    var iww = _infoWindows[markerId];
    if (iww != null) {
      iww.open = false;
      iww.infoWindow.close();
    }
  }

  Future<bool> isMarkerInfoWindowShown(String markerId) async {
    var iww = _infoWindows[markerId];
    if (iww != null) {
      return iww.open;
    }
    return false;
  }

  Future<void> showMarkerInfoWindow(String markerId) async {
    var iww = _infoWindows[markerId];
    if (iww != null) {
      iww.infoWindow.open();
      iww.open = true;
    }
  }
}

class _InfoWindowWrapper {
  final maps.InfoWindow infoWindow;
  bool open = false;

  _InfoWindowWrapper(this.infoWindow, {this.open: false});
}

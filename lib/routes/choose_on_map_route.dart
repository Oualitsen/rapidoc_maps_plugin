import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rapidoc_maps_plugin/choose_on_map.dart';
import 'package:rapidoc_maps_plugin/lang/langs.dart';

class ChooseOnMapRoute extends StatelessWidget {
  final String langName;
  final LatLng? initial;
  final double zoom;
  const ChooseOnMapRoute(
      {Key? key, this.langName = "en", this.initial, this.zoom = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lang = findLangByName(langName);
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.chooseOnMap),
      ),
      body: ChooseOnMap(
        initialPosition: initial,
        zoom: zoom,
        onPlaceSelected: (s) => Navigator.of(context).pop(s),
      ),
    );
  }
}

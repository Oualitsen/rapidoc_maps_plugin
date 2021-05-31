import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rapidoc_maps_plugin/choose_on_map.dart';
import 'package:rapidoc_maps_plugin/lang/Langs.dart';

class ChooseOnMapRoute extends StatelessWidget {
  const ChooseOnMapRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lang = appLocalizationsWrapper.lang;
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.chooseOnMap),
      ),
      body: ChooseOnMap(
        initialPosition: ModalRoute.of(context)?.settings.arguments as LatLng?,
        onPlaceSelected: (s) => Navigator.of(context).pop(s),
      ),
    );
  }
}

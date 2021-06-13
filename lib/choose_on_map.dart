import 'package:flutter/material.dart';
import 'package:flutter_responsive_tools/screen_type_layout.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rapidoc_maps_plugin/lang/Langs.dart';
import 'package:rapidoc_maps_plugin/maps/maps_stub.dart';

class ChooseOnMap extends StatefulWidget {
  final Function(LatLng?) onPlaceSelected;
  final LatLng? initialPosition;

  ChooseOnMap({Key? key, required this.onPlaceSelected, this.initialPosition}) : super(key: key);

  @override
  _ChooseOnMapState createState() => _ChooseOnMapState();
}

class _ChooseOnMapState extends State<ChooseOnMap> {
  final key = GlobalKey<MapsState>();

  @override
  Widget build(BuildContext context) {
    final lang = appLocalizationsWrapper.lang;
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Maps(
                key: key,
                initialPosition: widget.initialPosition,
              ),
              Align(
                child: Icon(
                  Icons.place,
                  size: 48,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: AutoScreenTypeLayout(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () => widget.onPlaceSelected(null),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.clear,
                        color: Theme.of(context).accentColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        lang.cancel,
                        style: TextStyle(color: Theme.of(context).accentColor),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (key.currentState != null) {
                      widget.onPlaceSelected(key.currentState!.center);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.done),
                      SizedBox(
                        width: 10,
                      ),
                      Text(lang.selectThisPosition)
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

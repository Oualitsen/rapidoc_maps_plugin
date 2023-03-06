import 'package:flutter/material.dart';
import 'package:flutter_responsive_tools/screen_type_layout.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rapidoc_maps_plugin/lang/langs.dart';
import 'package:rapidoc_maps_plugin/maps/my_map.dart';

class ChooseOnMap extends StatefulWidget {
  final Function(LatLng?) onPlaceSelected;
  final LatLng? initialPosition;
  final String langName;
  final double zoom;
  const ChooseOnMap(
      {Key? key,
      required this.onPlaceSelected,
      this.initialPosition,
      this.langName = "en",
      this.zoom = 10})
      : super(key: key);

  @override
  _ChooseOnMapState createState() => _ChooseOnMapState();
}

class _ChooseOnMapState extends State<ChooseOnMap> {
  final key = GlobalKey<MapsState>();
  late final Lang lang;
  @override
  void initState() {
    lang = findLangByName(widget.langName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Maps(
                key: key,
                initialPosition: widget.initialPosition,
                zoom: widget.zoom,
              ),
              const Align(
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
                      const Icon(Icons.clear),
                      const SizedBox(width: 10),
                      Text(lang.cancel)
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (key.currentState != null) {
                      widget.onPlaceSelected(key.currentState!.center);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(Icons.done),
                      const SizedBox(width: 10),
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

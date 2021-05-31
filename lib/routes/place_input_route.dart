import 'package:flutter_responsive_tools/screen_type_layout.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:infinite_scroll_list_view/infinite_scroll_list_view.dart';
import 'package:rapidoc_maps_plugin/googleApiModel/Prediction.dart';
import 'package:flutter/material.dart';
import 'package:rapidoc_maps_plugin/lang/Langs.dart';
import 'package:rapidoc_maps_plugin/routes/choose_on_map_route.dart';
import 'package:rapidoc_utils/utils/Utils.dart';
import 'package:rapidoc_utils/utils/error_handler.dart';
import 'package:rxdart/rxdart.dart';

class PlaceInputRoute extends StatefulWidget {
  final Future<List<Prediction>?> Function(String) searchFunction;
  final Future<String> Function(LatLng) reverseGeocode;
  final Future<LatLng> Function(String placeId) geocode;

  PlaceInputRoute({
    Key? key,
    required this.searchFunction,
    required this.reverseGeocode,
    required this.geocode,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => PlaceInputRouteState();
}

class PlaceInputRouteState extends State<PlaceInputRoute> {
  final BehaviorSubject<String> _searchSubject = BehaviorSubject.seeded("");

  bool _searching = true;

  final key = GlobalKey<InfiniteScrollListViewState<Prediction>>();

  @override
  void dispose() {
    _searchSubject.close();
    super.dispose();
  }

  @override
  void initState() {
    _searchSubject
        .debounceTime(Duration(milliseconds: 500))
        .where((e) => key.currentState != null)
        .listen((event) {
      key.currentState!.reload();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lang = appLocalizationsWrapper.lang;
    final String text = ModalRoute.of(context)!.settings.arguments as String? ?? lang.search;

    return Scaffold(
      appBar: AppBar(
        title: _buildTitle(context, text),
        actions: _buildActions(context),
      ),
      body: Column(
        children: [
          createHeader(context),
          Expanded(
            child: InfiniteScrollListView<Prediction>(
              key: key,
              pageLoader: loadData,
              elementBuilder: (p, a) => ListTile(
                title: Text(p.structuredFormatting?.mainText ?? ""),
                subtitle: Text(p.structuredFormatting?.secondaryText ?? ""),
                onTap: () async {
                  var position = await getAddress(p, context);
                  if (position != null) {
                    Navigator.of(context).pop(position);
                  }
                },
              ),
              noDataWidget: SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }

  Future<Position?> getAddress(Prediction p, BuildContext context) async {
    var response = await safeCall(widget.geocode(p.placeId!), context);
    if (response != null) {
      return Position(latLng: response, formattedAddress: p.structuredFormatting?.mainText ?? "");
    }
  }

  Widget _buildTitle(BuildContext context, String title) {
    if (_searching) {
      return TextField(
        autofocus: true,
        decoration: InputDecoration(border: InputBorder.none, hintText: title),
        onChanged: (text) {
          _searchSubject.add(text);
        },
      );
    } else {
      return Text(appLocalizationsWrapper.lang.search);
    }
  }

  List<Widget> _buildActions(BuildContext context) {
    if (_searching) {
      return [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            setState(() {
              _searching = false;
            });
          },
        )
      ];
    } else {
      return [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            setState(() {
              _searching = true;
            });
          },
        )
      ];
    }
  }

  Widget createHeader(context) {
    var lang = appLocalizationsWrapper.lang;
    return AutoScreenTypeLayout(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                onPressed: () async {
                  var result = await Navigator.of(context).push<LatLng>(
                    MaterialPageRoute(
                      builder: (context) => ChooseOnMapRoute(),
                    ),
                  );

                  if (result != null) {
                    LatLng latLng = result;

                    try {
                      String address = await widget.reverseGeocode(lang);

                      Navigator.of(context).pop(
                        Position(
                          latLng: latLng,
                          formattedAddress: address,
                        ),
                      );
                    } catch (error) {
                      showServerError(context, error: error);
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.place),
                      SizedBox(
                        height: 5,
                      ),
                      Text(lang.chooseOnMap.toUpperCase())
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                onPressed: () async {
                  try {
                    var pos = await getCurrentPosition();
                    var latLng = LatLng(
                      pos.latitude,
                      pos.longitude,
                    );

                    String address = await widget.reverseGeocode(lang);

                    Navigator.of(context).pop(
                      Position(
                        latLng: latLng,
                        formattedAddress: address,
                      ),
                    );
                  } catch (error) {
                    showServerError(context, error: error);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.gps_fixed),
                      SizedBox(
                        height: 5,
                      ),
                      Text(lang.currentLocation.toUpperCase())
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Prediction>?> loadData(int pageIndex) {
    if (pageIndex == 0) {
      var text = _searchSubject.value;
      if (text.isNotEmpty) {
        widget.searchFunction(text);
      }
    }
    return Future.value([]);
  }
}

class Position {
  final LatLng latLng;
  final String formattedAddress;

  Position({required this.latLng, required this.formattedAddress});
}
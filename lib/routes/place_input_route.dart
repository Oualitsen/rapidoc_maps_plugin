import 'package:dio/dio.dart';
import 'package:flutter_responsive_tools/screen_type_layout.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http_error_handler/error_handler.dart';
import 'package:infinite_scroll_list_view/infinite_scroll_list_view.dart';
import 'package:rapidoc_maps_plugin/model/lat_lng.dart' as model;
import 'package:rapidoc_maps_plugin/model/prediction.dart';
import 'package:flutter/material.dart';
import 'package:rapidoc_maps_plugin/lang/langs.dart';
import 'package:rapidoc_maps_plugin/routes/choose_on_map_route.dart';
import 'package:rapidoc_maps_plugin/services/search_service.dart';
import 'package:rxdart/rxdart.dart';

class PlaceInputRoute extends StatefulWidget {
  final Dio dio;
  final String langName;

  /// something like country:dz
  final String? component;

  const PlaceInputRoute({
    Key? key,
    required this.dio,
    this.langName = "en",
    this.component,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => PlaceInputRouteState();
}

class PlaceInputRouteState extends State<PlaceInputRoute> {
  final BehaviorSubject<String> _searchSubject = BehaviorSubject.seeded("");
  late final SearchService service;
  final BehaviorSubject<bool> _searching = BehaviorSubject.seeded(true);

  final key = GlobalKey<InfiniteScrollListViewState<Prediction>>();

  late final Lang lang;

  @override
  void initState() {
    service = SearchService(widget.dio);
    lang = findLangByName(widget.langName);
    _searchSubject
        .debounceTime(const Duration(milliseconds: 500))
        .where((e) => key.currentState != null)
        .where((event) => event.isNotEmpty)
        .listen((event) {
      key.currentState!.reload();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String text =
        ModalRoute.of(context)!.settings.arguments as String? ?? lang.search;

    return Scaffold(
      appBar: AppBar(
        title: _buildTitle(context, text),
        actions: _buildActions(context),
      ),
      body: Column(
        children: [
          StreamBuilder<String>(
              stream: _searchSubject,
              initialData: _searchSubject.valueOrNull,
              builder: (context, snapshot) {
                var text = snapshot.data;
                if (text != null && text.isNotEmpty) {
                  return const SizedBox.shrink();
                }
                return createHeader(context);
              }),
          Expanded(
            child: InfiniteScrollListView<Prediction>(
              key: key,
              pageLoader: loadData,
              elementBuilder: (c, p, i, a) => ListTile(
                title: Text(p.structuredFormatting?.mainText ?? ""),
                subtitle: Text(p.structuredFormatting?.secondaryText ?? ""),
                onTap: () {
                  getAddress(p, context)
                      .asStream()
                      .listen(Navigator.of(context).pop);
                },
              ),
              noDataWidget: const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }

  Future<Position> getAddress(Prediction p, BuildContext context) {
    return service
        .geocode(p.placeId!)
        .asStream()
        .map((event) => Position(
            latLng: event,
            formattedAddress: p.structuredFormatting?.mainText ?? ""))
        .first;
  }

  Widget _buildTitle(BuildContext context, String title) {
    return StreamBuilder<bool>(
      stream: _searching,
      initialData: _searching.value,
      builder: (context, snapshot) {
        var __searching = snapshot.data ?? false;
        if (__searching) {
          return TextField(
            autofocus: true,
            decoration:
                InputDecoration(border: InputBorder.none, hintText: title),
            onChanged: (text) {
              _searchSubject.add(text);
            },
          );
        } else {
          return Text(lang.search);
        }
      },
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return [
      StreamBuilder<bool>(
        builder: (context, snapshot) {
          var __searching = snapshot.data ?? false;
          if (__searching) {
            return IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchSubject.add("");
                _searching.add(false);
              },
            );
          } else {
            return IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => _searching.add(true),
            );
          }
        },
        initialData: _searching.value,
        stream: _searching,
      )
    ];
  }

  Widget createHeader(context) {
    return AutoScreenTypeLayout(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push<LatLng>(
                        MaterialPageRoute(
                          builder: (context) => const ChooseOnMapRoute(),
                        ),
                      )
                      .asStream()
                      .where((event) => event != null)
                      .map((event) => event!)
                      .flatMap(
                        (latLng) => service
                            .reverseGeocode([latLng.latitude, latLng.longitude])
                            .asStream()
                            .map(
                              (address) => Position(
                                latLng: model.LatLng(
                                    lat: latLng.latitude,
                                    lng: latLng.longitude),
                                formattedAddress: address,
                              ),
                            ),
                      )
                      .doOnError(
                          (p0, p1) => showServerError(context, error: p0))
                      .listen(Navigator.of(context).pop);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      const Icon(Icons.place),
                      const SizedBox(
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
                  Geolocator.getCurrentPosition(
                          timeLimit: const Duration(seconds: 10))
                      .asStream()
                      .asyncMap((latLng) => service
                          .reverseGeocode([latLng.latitude, latLng.longitude]))
                      .doOnError(
                          (p0, p1) => showServerError(context, error: p0))
                      .listen((text) => Navigator.of(context).pop(text));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      const Icon(Icons.gps_fixed),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(lang.currentPosition.toUpperCase())
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

  @override
  void dispose() {
    _searchSubject.close();
    _searching.close();
    super.dispose();
  }

  Future<List<Prediction>?> loadData(int pageIndex) {
    if (pageIndex == 0) {
      var text = _searchSubject.value;
      if (text.isNotEmpty) {
        return service.search(text,
            lang: widget.langName, component: widget.component);
      }
    }
    return Future.value([]);
  }
}

class Position {
  final model.LatLng latLng;
  final String formattedAddress;

  Position({required this.latLng, required this.formattedAddress});
}

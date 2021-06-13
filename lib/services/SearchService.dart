import 'package:rapidoc_maps_plugin/googleApiModel/LatLng.dart';
import 'package:rapidoc_maps_plugin/googleApiModel/Prediction.dart';

abstract class SearchService {
  Future<List<Prediction>?> search(String term);
  Future<LatLng> geocode(String placeId);
  Future<String> reverseGeocode(LatLng latlng);
}

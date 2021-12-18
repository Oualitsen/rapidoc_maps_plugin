import 'package:dio/dio.dart';
import 'package:rapidoc_maps_plugin/model/lat_lng.dart';
import 'package:rapidoc_maps_plugin/model/prediction.dart';
import 'package:retrofit/retrofit.dart';
part 'search_service.g.dart';

@RestApi()
abstract class SearchService {
  factory SearchService(Dio dio) = _SearchService;

  @POST("/maps/places")
  Future<List<Prediction>> search(
    @Body() String term, {
    @Query("lang") String? lang,
    @Query("component") String? component,
  });

  @GET("/maps/places/get-place/{placeId}")
  Future<LatLng> geocode(@Path("placeId") String placeId,
      {@Query("lang") String? lang});

  @POST("/maps/places/reverse-geocode")
  Future<String> reverseGeocode(@Body() List<double> latLng,
      {@Query("lang") String? lang});
}

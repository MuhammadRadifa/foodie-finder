import 'package:foodie_finder/data/dto/restaurant_detail_dto.dart';
import 'package:foodie_finder/data/source/networks/api.dart';
import 'package:foodie_finder/domain/entity/restaurant.dart';
import 'package:foodie_finder/domain/entity/restaurant_detail.dart';
import 'package:foodie_finder/domain/repository/restaurant_repository.dart';

class RestaurantImpl extends RestaurantRepository {
  final Api _api;

  RestaurantImpl({required Api api}) : _api = api;

  @override
  Future<List<Restaurant>> getAllRestaurants() async {
    try {
      return await _api.getAllRestaurants();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<RestaurantDetail> getRestaurantDetail(String id) async {
    try {
      return await _api.getRestaurantDetail(id);
    } catch (e) {
      return RestaurantDetailDto.empty();
    }
  }
}

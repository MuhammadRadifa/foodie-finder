import 'package:foodie_finder/domain/entity/restaurant.dart';
import 'package:foodie_finder/domain/entity/restaurant_detail.dart';

abstract class RestaurantRepository {
  Future<List<Restaurant>> getAllRestaurants();
  Future<RestaurantDetail> getRestaurantDetail(String id);
}

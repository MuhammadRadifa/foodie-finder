import 'package:foodie_finder/data/dto/restaurant_detail_dto.dart';
import 'package:foodie_finder/data/dto/restaurant_dto.dart';
import 'package:foodie_finder/domain/entity/restaurant.dart';
import 'package:foodie_finder/domain/entity/restaurant_detail.dart';
import 'package:foodie_finder/domain/repository/restaurant_repository.dart';

class RestaurantUseCase {
  RestaurantUseCase({required RestaurantRepository restaurantRepository})
    : _restaurantRepository = restaurantRepository;

  final RestaurantRepository _restaurantRepository;

  Future<List<Restaurant>> getAllRestaurants() {
    return _restaurantRepository.getAllRestaurants();
  }

  Future<RestaurantDetail> getRestaurantDetail(String id) {
    return _restaurantRepository.getRestaurantDetail(id);
  }
}

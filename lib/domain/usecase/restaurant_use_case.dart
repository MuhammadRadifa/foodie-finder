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

  Future<List<Restaurant>> getAllRestaurantsByQuery(String query) {
    return _restaurantRepository.getAllRestaurantsByQuery(query);
  }

  Future<void> addReview(String id, String name, String review) {
    return _restaurantRepository.addReview(id, name, review);
  }

  Future<List<Restaurant>> getAllFavorites() {
    return _restaurantRepository.getAllFavorites();
  }

  Future<Restaurant?> getFavoriteById(String id) {
    return _restaurantRepository.getFavoriteById(id);
  }

  Future<int> addFavorite(Restaurant restaurant) {
    return _restaurantRepository.addFavorite(restaurant);
  }

  Future<int> removeFavorite(String id) {
    return _restaurantRepository.removeFavorite(id);
  }
}

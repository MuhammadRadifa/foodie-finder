import 'package:flutter/widgets.dart';
import 'package:foodie_finder/data/constant/restaurant_list_status.dart';
import 'package:foodie_finder/domain/entity/restaurant.dart';
import 'package:foodie_finder/domain/usecase/restaurant_use_case.dart';

class FavoriteProvider extends ChangeNotifier {
  final RestaurantUseCase _restaurantUseCase;

  RestaurantListResultState _resultState = RestaurantListNoneState();

  RestaurantListResultState get resultState => _resultState;

  FavoriteProvider({required RestaurantUseCase restaurantUseCase})
    : _restaurantUseCase = restaurantUseCase;

  Future<List<Restaurant>> fetchAllFavoriteRestaurants() async {
    try {
      _resultState = RestaurantListLoadingState();
      notifyListeners();
      final favorites = await _restaurantUseCase.getAllFavorites();

      if (favorites.isEmpty) {
        _resultState = RestaurantListErrorState(
          'No favorite restaurants found',
        );
        notifyListeners();
        return [];
      }

      _resultState = RestaurantListSuccessState<List<Restaurant>>(favorites);
      notifyListeners();
      return favorites;
    } catch (e) {
      _resultState = RestaurantListErrorState(
        'Failed to load favorite restaurants: $e',
      );
      notifyListeners();

      return [];
    }
  }

  Future<Restaurant?> fetchFavoriteRestaurantById(String id) async {
    try {
      _resultState = RestaurantListLoadingState();
      notifyListeners();
      final restaurant = await _restaurantUseCase.getFavoriteById(id);

      if (restaurant == null) {
        _resultState = RestaurantListErrorState('Restaurant not found');
        notifyListeners();
        return null;
      }

      _resultState = RestaurantListSuccessState<Restaurant>(restaurant);
      notifyListeners();
      return restaurant;
    } catch (e) {
      _resultState = RestaurantListErrorState('Failed to load restaurant: $e');
      notifyListeners();

      return null;
    }
  }

  Future<void> addFavoriteRestaurant(Restaurant restaurant) async {
    try {
      _resultState = RestaurantListLoadingState();
      notifyListeners();
      final id = await _restaurantUseCase.addFavorite(restaurant);

      if (id <= 0) {
        _resultState = RestaurantListErrorState('Failed to add favorite');
        notifyListeners();
        return;
      }

      _resultState = RestaurantListSuccessState<String>(
        "success added to favorites",
      );
      notifyListeners();
    } catch (e) {
      _resultState = RestaurantListErrorState('Failed to add favorite: $e');
      notifyListeners();
    }
  }

  Future<void> removeFavoriteRestaurant(String id) async {
    try {
      _resultState = RestaurantListLoadingState();
      notifyListeners();
      final success = await _restaurantUseCase.removeFavorite(id);

      if (success <= 0) {
        _resultState = RestaurantListErrorState('Failed to remove favorite');
        notifyListeners();
        return;
      }

      _resultState = RestaurantListSuccessState<String>(
        "success removed from favorites",
      );
      notifyListeners();
    } catch (e) {
      _resultState = RestaurantListErrorState('Failed to remove favorite: $e');
      notifyListeners();
    }
  }
}

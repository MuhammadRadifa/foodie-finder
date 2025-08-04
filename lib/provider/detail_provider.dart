import 'package:flutter/material.dart';
import 'package:foodie_finder/data/constant/restaurant_list_status.dart';
import 'package:foodie_finder/domain/entity/restaurant_detail.dart';
import 'package:foodie_finder/domain/usecase/restaurant_use_case.dart';

class DetailProvider extends ChangeNotifier {
  final RestaurantUseCase _restaurantUseCase;

  RestaurantListResultState _resultState = RestaurantListNoneState();

  RestaurantListResultState get resultState => _resultState;

  DetailProvider({required RestaurantUseCase restaurantUseCase})
    : _restaurantUseCase = restaurantUseCase;

  Future<void> fetchRestaurantDetails(String restaurantId) async {
    try {
      _resultState = RestaurantListLoadingState();
      notifyListeners();

      final restaurant = await _restaurantUseCase.getRestaurantDetail(
        restaurantId,
      );

      if (restaurant.id.isEmpty) {
        _resultState = RestaurantListErrorState('Restaurant not found');
        notifyListeners();
        return;
      }

      _resultState = RestaurantListSuccessState<RestaurantDetail>(restaurant);
      notifyListeners();
    } catch (e) {
      _resultState = RestaurantListErrorState(
        'Failed to load restaurant details: $e',
      );
      notifyListeners();
      rethrow;
    }
  }

  Future<void> addReview(String id, String name, String review) async {
    try {
      await _restaurantUseCase.addReview(id, name, review);
      _resultState = RestaurantListSuccessState<String>(
        'Review added successfully',
      );
      notifyListeners();
    } catch (e) {
      _resultState = RestaurantListErrorState('Failed to add review: $e');
      notifyListeners();
    }
  }
}

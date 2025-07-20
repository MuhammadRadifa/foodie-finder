import 'package:foodie_finder/domain/entity/restaurant.dart';

sealed class RestaurantListResultState {}

class RestaurantListNoneState extends RestaurantListResultState {}

class RestaurantListLoadingState extends RestaurantListResultState {}

class RestaurantListSuccessState extends RestaurantListResultState {
  final List<Restaurant> restaurants;

  RestaurantListSuccessState(this.restaurants);
}

class RestaurantListErrorState extends RestaurantListResultState {
  final String message;

  RestaurantListErrorState(this.message);
}

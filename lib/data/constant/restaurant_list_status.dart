sealed class RestaurantListResultState {}

class RestaurantListNoneState extends RestaurantListResultState {}

class RestaurantListLoadingState extends RestaurantListResultState {}

class RestaurantListSuccessState<T> extends RestaurantListResultState {
  final T data;

  RestaurantListSuccessState(this.data);
}

class RestaurantListErrorState extends RestaurantListResultState {
  final String message;

  RestaurantListErrorState(this.message);
}

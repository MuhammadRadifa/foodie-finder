import 'package:dio/dio.dart';
import 'package:foodie_finder/data/constant/config.dart';
import 'package:foodie_finder/data/dto/restaurant_detail_dto.dart';
import 'package:foodie_finder/data/dto/restaurant_dto.dart';
import 'package:foodie_finder/domain/entity/restaurant.dart';

abstract class Api {
  Future<List<Restaurant>> getAllRestaurants();
  Future<RestaurantDetailDto> getRestaurantDetail(String id);
}

class ApiImpl implements Api {
  final dio = Dio();

  @override
  Future<List<Restaurant>> getAllRestaurants() async {
    final response = await dio.get("https://restaurant-api.dicoding.dev/list");

    if (response.statusCode == 200) {
      final List<dynamic> restaurantsJson = response.data['restaurants'];

      final List<Restaurant> restaurants = restaurantsJson
          .map((json) => RestaurantDto.fromJson(json))
          .toList();

      return restaurants;
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  @override
  Future<RestaurantDetailDto> getRestaurantDetail(String id) async {
    final response = await dio.get(
      'https://restaurant-api.dicoding.dev/detail/$id',
    );

    if (response.statusCode == 200) {
      return RestaurantDetailDto.fromJson(response.data['restaurant']);
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }
}

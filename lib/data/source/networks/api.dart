import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:foodie_finder/data/dto/restaurant_detail_dto.dart';
import 'package:foodie_finder/data/dto/restaurant_dto.dart';
import 'package:foodie_finder/domain/entity/restaurant.dart';

abstract class Api {
  Future<List<Restaurant>> getAllRestaurants();
  Future<List<Restaurant>> getAllRestaurantsByQuery(String query);
  Future<RestaurantDetailDto> getRestaurantDetail(String id);
  // add review
  Future<void> addReview(String id, String name, String review);
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
    debugPrint('Response: ${response.data}');

    if (response.statusCode == 200) {
      return RestaurantDetailDto.fromJson(response.data['restaurant']);
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  @override
  Future<List<Restaurant>> getAllRestaurantsByQuery(String query) async {
    final response = await dio.get(
      'https://restaurant-api.dicoding.dev/search?q=$query',
    );

    if (response.statusCode == 200) {
      final List<dynamic> restaurantsJson = response.data['restaurants'];

      final List<Restaurant> restaurants = restaurantsJson
          .map((json) => RestaurantDto.fromJson(json))
          .toList();

      return restaurants;
    } else {
      throw Exception('Failed to search restaurants');
    }
  }

  @override
  Future<void> addReview(String id, String name, String review) async {
    final response = await dio.post(
      'https://restaurant-api.dicoding.dev/review',
      data: {'id': id, 'name': name, 'review': review},
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add review');
    }
  }
}

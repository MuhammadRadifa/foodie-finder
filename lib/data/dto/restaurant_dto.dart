import 'dart:convert';
import 'package:foodie_finder/domain/entity/restaurant.dart';

class RestaurantDto extends Restaurant {
  RestaurantDto({
    required super.id,
    required super.name,
    required super.description,
    required super.pictureId,
    required super.rating,
    required super.city,
  });
  factory RestaurantDto.fromRawJson(String str) =>
      RestaurantDto.fromJson(json.decode(str));

  factory RestaurantDto.fromJson(Map<String, dynamic> json) {
    return RestaurantDto(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      pictureId: json['pictureId'],
      rating: json['rating']?.toDouble() ?? 0.0,
      city: json['city'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pictureId': pictureId,
      'rating': rating,
      'city': city,
    };
  }

  factory RestaurantDto.empty() {
    return RestaurantDto(
      id: '',
      name: '',
      description: '',
      pictureId: '',
      rating: 0.0,
      city: '',
    );
  }
}

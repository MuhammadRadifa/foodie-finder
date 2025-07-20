import 'dart:convert';
import 'package:foodie_finder/domain/entity/restaurant_detail.dart';

class RestaurantDetailDto extends RestaurantDetail {
  RestaurantDetailDto({
    required super.id,
    required super.name,
    required super.description,
    required super.city,
    required super.address,
    required super.pictureId,
    required super.categories,
    required super.menus,
    required super.rating,
    required super.customerReviews,
  });

  factory RestaurantDetailDto.fromRawJson(String str) =>
      RestaurantDetailDto.fromJson(json.decode(str));

  factory RestaurantDetailDto.fromJson(Map<String, dynamic> json) {
    return RestaurantDetailDto(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      city: json['city'] ?? '',
      address: json['address'] ?? '',
      pictureId: json['pictureId'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map((x) => Category.fromJson(x))
              .toList() ??
          [],
      menus: json['menus'] != null
          ? Menus.fromJson(json['menus'])
          : Menus(foods: [], drinks: []),
      customerReviews:
          (json['customerReviews'] as List<dynamic>?)
              ?.map((x) => CustomerReview.fromJson(x))
              .toList() ??
          [],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'city': city,
      'address': address,
      'pictureId': pictureId,
      'rating': rating,
      'categories': categories.map((x) => x.toJson()).toList(),
      'menus': menus.toJson(),
      'customerReviews': customerReviews.map((x) => x.toJson()).toList(),
    };
  }

  factory RestaurantDetailDto.empty() {
    return RestaurantDetailDto(
      id: '',
      name: '',
      description: '',
      city: '',
      address: '',
      pictureId: '',
      rating: 0.0,
      categories: [],
      menus: Menus(foods: [], drinks: []),
      customerReviews: [],
    );
  }
}

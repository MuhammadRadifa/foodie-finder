import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_finder/domain/entity/restaurant.dart';
import 'package:foodie_finder/provider/restaurant_provider.dart';
import 'package:foodie_finder/domain/usecase/restaurant_use_case.dart';
import 'package:foodie_finder/data/constant/restaurant_list_status.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'restaurant_list_provider_test.mocks.dart';

@GenerateMocks([RestaurantUseCase])
void main() {
  late MockRestaurantUseCase mockUseCase;
  late HomeProvider homeProvider;

  setUp(() {
    mockUseCase = MockRestaurantUseCase();
    homeProvider = HomeProvider(restaurantUseCase: mockUseCase);
  });

  group('HomeProvider Tests', () {
    /// Test 1: State awal
    test('state awal harus RestaurantListNoneState', () {
      expect(homeProvider.resultState, isA<RestaurantListNoneState>());
    });

    /// Test 2: API sukses
    test('harus mengembalikan list restoran ketika API sukses', () async {
      final dummyRestaurants = [
        Restaurant(
          id: '1',
          name: 'Sushi Restaurant',
          description: 'Authentic Japanese sushi',
          pictureId: 'pic1',
          city: 'Tokyo',
          rating: 4.5,
        ),
        Restaurant(
          id: '2',
          name: 'Pizza Corner',
          description: 'Italian style pizza',
          pictureId: 'pic2',
          city: 'Rome',
          rating: 4.7,
        ),
      ];

      when(
        mockUseCase.getAllRestaurants(),
      ).thenAnswer((_) async => dummyRestaurants);

      final result = await homeProvider.fetchAllRestaurants();

      verify(mockUseCase.getAllRestaurants()).called(1);
      expect(result, equals(dummyRestaurants));
      expect(homeProvider.resultState, isA<RestaurantListSuccessState>());

      final successState =
          homeProvider.resultState as RestaurantListSuccessState;
      expect(successState.data, equals(dummyRestaurants));
    });

    /// Test 3: API gagal
    test('harus mengembalikan error ketika API gagal', () async {
      when(
        mockUseCase.getAllRestaurants(),
      ).thenThrow(Exception('Network error'));

      final result = await homeProvider.fetchAllRestaurants();

      verify(mockUseCase.getAllRestaurants()).called(1);
      expect(result, isEmpty);
      expect(homeProvider.resultState, isA<RestaurantListErrorState>());

      final errorState = homeProvider.resultState as RestaurantListErrorState;
      expect(errorState.message, contains('Failed to load restaurants'));
      expect(errorState.message, contains('Network error'));
    });
  });
}

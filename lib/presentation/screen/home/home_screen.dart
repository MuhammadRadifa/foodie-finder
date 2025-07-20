import 'package:flutter/material.dart';
import 'package:foodie_finder/data/constant/restaurant_list_status.dart';
import 'package:foodie_finder/domain/usecase/restaurant_use_case.dart';
import 'package:foodie_finder/presentation/shared/app_bar_container.dart';
import 'package:foodie_finder/presentation/shared/bottom_bar_container.dart';
import 'package:foodie_finder/presentation/shared/list_restaurant_card.dart';
import 'package:foodie_finder/provider/restaurant_provider.dart';
import 'package:foodie_finder/style/colors/colors.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;

      context.read<HomeProvider>().fetchAllRestaurants();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppColors.backgroundColor),
      appBar: const AppBarContainer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/image/cover.png',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.black.withOpacity(0.5),
              ),
              Text(
                'Find Your Perfect Meal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Welcome to Foodie Finder',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            // <- Now valid
            child: Consumer<HomeProvider>(
              builder: (context, provider, child) {
                if (provider.resultState is RestaurantListLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (provider.resultState is RestaurantListErrorState) {
                  final errorState =
                      provider.resultState as RestaurantListErrorState;
                  return Center(
                    child: Text(
                      errorState.message,
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                } else if (provider.resultState is RestaurantListSuccessState) {
                  final successState =
                      provider.resultState as RestaurantListSuccessState;
                  final restaurants = successState.restaurants;

                  return ListView.builder(
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = restaurants[index];
                      return ListRestaurantCard(
                        name: restaurant.name,
                        description: restaurant.description,
                        imageUrl:
                            "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                        city: restaurant.city,
                        rating: restaurant.rating,
                      );
                    },
                  );
                }
                return const SizedBox.shrink(); // fallback
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomBarContainer(),
    );
  }
}

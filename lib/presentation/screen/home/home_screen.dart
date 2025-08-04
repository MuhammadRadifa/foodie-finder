import 'package:flutter/material.dart';
import 'package:foodie_finder/data/constant/navigation_route.dart';
import 'package:foodie_finder/data/constant/restaurant_list_status.dart';
import 'package:foodie_finder/domain/entity/restaurant.dart';
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const AppBarContainer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hero Section
            SizedBox(
              height: 200,
              child: Stack(
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
                    color: Colors.black.withValues(alpha: 0.5),
                  ),
                  Positioned.fill(
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Find Your Perfect Meal',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            Flexible(
                              child: Center(
                                child: Container(
                                  width: double.infinity,
                                  constraints: const BoxConstraints(
                                    maxWidth: 400,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.1,
                                        ),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText:
                                          'Search restaurants, food, drinks...',
                                      hintStyle: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 14,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: Colors.grey[600],
                                        size: 20,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 12,
                                          ),
                                    ),
                                    onSubmitted: (value) {
                                      Navigator.pushNamed(
                                        context,
                                        NavigationRoute.search.route,
                                        arguments: value,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Welcome Section
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Welcome to Foodie Finder',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Restaurant List
            Consumer<HomeProvider>(
              builder: (context, provider, child) {
                if (provider.resultState is RestaurantListLoadingState) {
                  return const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (provider.resultState is RestaurantListErrorState) {
                  final errorState =
                      provider.resultState as RestaurantListErrorState;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      errorState.message,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else if (provider.resultState is RestaurantListSuccessState) {
                  final successState =
                      provider.resultState
                          as RestaurantListSuccessState<List<Restaurant>>;
                  final restaurants = successState.data;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = restaurants[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ListRestaurantCard(
                          id: restaurant.id,
                          name: restaurant.name,
                          description: restaurant.description,
                          imageUrl:
                              "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                          city: restaurant.city,
                          rating: restaurant.rating,
                        ),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),

            // Add bottom padding for bottom navigation
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBarContainer(),
    );
  }
}

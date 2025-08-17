import 'package:flutter/material.dart';
import 'package:foodie_finder/data/constant/restaurant_list_status.dart';
import 'package:foodie_finder/domain/entity/restaurant.dart';
import 'package:foodie_finder/presentation/shared/app_bar_container.dart';
import 'package:foodie_finder/presentation/shared/bottom_bar_container.dart';
import 'package:foodie_finder/presentation/shared/list_restaurant_card.dart';
import 'package:foodie_finder/provider/favorite_provider.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;

      context.read<FavoriteProvider>().fetchAllFavoriteRestaurants();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const AppBarContainer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Favorite Restaurants',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          Expanded(
            child: Consumer<FavoriteProvider>(
              builder: (context, provider, child) {
                return switch (provider.resultState) {
                  RestaurantListLoadingState() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  RestaurantListErrorState errorState => Center(
                    child: Text(errorState.message),
                  ),
                  RestaurantListSuccessState<List<Restaurant>> successState =>
                    ListView.builder(
                      itemCount: successState.data.length,
                      itemBuilder: (context, index) {
                        final restaurant = successState.data[index];
                        return ListRestaurantCard(
                          id: restaurant.id,
                          name: restaurant.name,
                          description: restaurant.description,
                          imageUrl:
                              "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                          city: restaurant.city,
                          rating: restaurant.rating,
                        );
                      },
                    ),
                  _ => const SizedBox.shrink(),
                };
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBarContainer(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:foodie_finder/data/constant/navigation_route.dart';
import 'package:foodie_finder/data/constant/restaurant_list_status.dart';
import 'package:foodie_finder/domain/entity/restaurant.dart';
import 'package:foodie_finder/presentation/shared/app_bar_container.dart';
import 'package:foodie_finder/presentation/shared/list_restaurant_card.dart';
import 'package:foodie_finder/provider/search_restaurant.dart';
import 'package:foodie_finder/style/colors/colors.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  final String query;

  const SearchScreen({super.key, required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;

      // Assuming you have a method to fetch search results based on the query
      context.read<SearchProvider>().fetchRestaurantsByQuery(widget.query);
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
              'Search Results for "${widget.query}"',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: Consumer<SearchProvider>(
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
    );
  }
}

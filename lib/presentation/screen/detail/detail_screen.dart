import 'package:flutter/material.dart';
import 'package:foodie_finder/data/constant/restaurant_list_status.dart';
import 'package:foodie_finder/domain/entity/restaurant_detail.dart';
import 'package:foodie_finder/presentation/screen/detail/body_detail_screen.dart';
import 'package:foodie_finder/presentation/shared/app_bar_container.dart';
import 'package:foodie_finder/provider/detail_provider.dart';
import 'package:foodie_finder/provider/favorite_provider.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final String id;

  const DetailScreen({super.key, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;

      context.read<DetailProvider>().fetchRestaurantDetails(widget.id);

      context
          .read<FavoriteProvider>()
          .fetchFavoriteRestaurantById(widget.id)
          .then((value) {
            setState(() {
              isFavorite = value != null ? true : false;
            });
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const AppBarContainer(),
      body: Consumer<DetailProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            RestaurantListLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            RestaurantListErrorState errorState => Center(
              child: Text(errorState.message),
            ),
            RestaurantListSuccessState<RestaurantDetail> successState =>
              BodyDetailScreen(data: successState.data, isFavorite: isFavorite),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}

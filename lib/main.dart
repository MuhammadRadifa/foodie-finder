import 'package:foodie_finder/data/source/networks/api.dart';
import 'package:foodie_finder/data/source/restaurant_impl.dart';
import 'package:foodie_finder/domain/usecase/restaurant_use_case.dart';
import 'package:foodie_finder/provider/restaurant_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:foodie_finder/presentation/screen/home/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<ApiImpl>(create: (_) => ApiImpl()),
        ProxyProvider<ApiImpl, RestaurantImpl>(
          update: (_, api, __) => RestaurantImpl(api: api),
        ),
        ProxyProvider<RestaurantImpl, RestaurantUseCase>(
          update: (_, repo, __) =>
              RestaurantUseCase(restaurantRepository: repo),
        ),
        ChangeNotifierProvider<HomeProvider>(
          create: (context) => HomeProvider(
            restaurantUseCase: Provider.of<RestaurantUseCase>(
              context,
              listen: false,
            ),
          ),
        ),
      ],
      child: const MainApp(), // or your actual App widget
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeScreen());
  }
}

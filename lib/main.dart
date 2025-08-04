import 'package:foodie_finder/data/constant/navigation_route.dart';
import 'package:foodie_finder/data/source/networks/api.dart';
import 'package:foodie_finder/data/source/restaurant_impl.dart';
import 'package:foodie_finder/domain/usecase/restaurant_use_case.dart';
import 'package:foodie_finder/presentation/screen/detail/detail_screen.dart';
import 'package:foodie_finder/presentation/screen/search/search_screen.dart';
import 'package:foodie_finder/presentation/screen/settings/settings_screen.dart';
import 'package:foodie_finder/provider/detail_provider.dart';
import 'package:foodie_finder/provider/restaurant_provider.dart';
import 'package:foodie_finder/provider/search_restaurant.dart';
import 'package:foodie_finder/provider/theme_provider.dart';
import 'package:foodie_finder/style/colors/colors.dart';
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
        ChangeNotifierProvider<DetailProvider>(
          create: (context) => DetailProvider(
            restaurantUseCase: Provider.of<RestaurantUseCase>(
              context,
              listen: false,
            ),
          ),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (context) => SearchProvider(
            restaurantUseCase: Provider.of<RestaurantUseCase>(
              context,
              listen: false,
            ),
          ),
        ),
        ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier()),
      ],
      child: const MainApp(), // or your actual App widget
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    var materialApp = MaterialApp(
      title: 'Foodie Finder',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: Provider.of<ThemeNotifier>(context).themeMode,
      initialRoute: NavigationRoute.home.route,
      routes: {
        NavigationRoute.home.route: (context) => const HomeScreen(),
        NavigationRoute.detail.route: (context) => DetailScreen(
          id: ModalRoute.of(context)?.settings.arguments as String,
        ),
        NavigationRoute.search.route: (context) => SearchScreen(
          query: ModalRoute.of(context)?.settings.arguments as String,
        ),
        NavigationRoute.settings.route: (context) => const SettingsScreen(),
      },
    );
    return materialApp;
  }
}

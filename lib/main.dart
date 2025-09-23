import 'package:foodie_finder/data/constant/navigation_route.dart';
import 'package:foodie_finder/data/source/local/database_service.dart';
import 'package:foodie_finder/data/source/networks/api.dart';
import 'package:foodie_finder/data/source/restaurant_impl.dart';
import 'package:foodie_finder/domain/usecase/restaurant_use_case.dart';
import 'package:foodie_finder/lib/services/local_notification_service.dart';
import 'package:foodie_finder/presentation/screen/detail/detail_screen.dart';
import 'package:foodie_finder/presentation/screen/favorite/favorite_screen.dart';
import 'package:foodie_finder/presentation/screen/search/search_screen.dart';
import 'package:foodie_finder/presentation/screen/settings/settings_screen.dart';
import 'package:foodie_finder/provider/detail_provider.dart';
import 'package:foodie_finder/provider/favorite_provider.dart';
import 'package:foodie_finder/provider/local_notification_provider.dart';
import 'package:foodie_finder/provider/restaurant_provider.dart';
import 'package:foodie_finder/provider/schedule_provider.dart';
import 'package:foodie_finder/provider/search_restaurant.dart';
import 'package:foodie_finder/provider/theme_provider.dart';
import 'package:foodie_finder/style/colors/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:foodie_finder/presentation/screen/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi timezone
  final localNotificationService = LocalNotificationService();
  await localNotificationService.configureLocalTimeZone();

  runApp(
    MultiProvider(
      providers: [
        Provider<ApiImpl>(create: (_) => ApiImpl()),
        Provider<DatabaseService>(create: (_) => DatabaseService()),
        ProxyProvider2<ApiImpl, DatabaseService, RestaurantImpl>(
          update: (context, api, db, previous) =>
              RestaurantImpl(api: api, databaseService: db),
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
        ChangeNotifierProvider<FavoriteProvider>(
          create: (context) => FavoriteProvider(
            restaurantUseCase: Provider.of<RestaurantUseCase>(
              context,
              listen: false,
            ),
          ),
        ),
        ChangeNotifierProvider<LocalNotificationProvider>(
          create: (context) => LocalNotificationProvider(
            context.read<LocalNotificationService>(),
          )..requestPermissions(),
        ),
        Provider<LocalNotificationService>(
          create: (_) => LocalNotificationService(),
        ),
        ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider<ScheduleProvider>(
          create: (context) {
            final notifService = context.read<LocalNotificationService>();
            return ScheduleProvider(notifService);
          },
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
        NavigationRoute.favorite.route: (context) => const FavoriteScreen(),
        NavigationRoute.settings.route: (context) => const SettingsScreen(),
      },
    );
    return materialApp;
  }
}

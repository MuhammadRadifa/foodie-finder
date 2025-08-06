import 'package:flutter/material.dart';
import 'package:foodie_finder/data/constant/navigation_route.dart';
import 'package:foodie_finder/style/colors/colors.dart';

class BottomBarContainer extends StatelessWidget {
  const BottomBarContainer({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current route to determine which tab should be selected
    final String currentRoute = ModalRoute.of(context)?.settings.name ?? '';

    // Determine which index should be selected based on the current route
    int currentIndex = 0; // Default to home tab
    if (currentRoute == NavigationRoute.settings.route) {
      currentIndex = 1;
    } else if (currentRoute == NavigationRoute.home.route) {
      currentIndex = 0;
    }

    return BottomNavigationBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Theme.of(
        context,
      ).colorScheme.primary.withValues(alpha: 0.6),
      onTap: (index) {
        // Navigate only if the selected tab is different from current route
        if (index == 0 && currentRoute != NavigationRoute.home.route) {
          Navigator.pushNamed(context, NavigationRoute.home.route);
        } else if (index == 1 &&
            currentRoute != NavigationRoute.settings.route) {
          Navigator.pushNamed(context, NavigationRoute.settings.route);
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:foodie_finder/style/colors/colors.dart';

class BottomBarContainer extends StatelessWidget {
  const BottomBarContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(AppColors.primaryColor),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
      selectedItemColor: Color(AppColors.backgroundColor),
      unselectedItemColor: Color(AppColors.accentColor),
    );
  }
}

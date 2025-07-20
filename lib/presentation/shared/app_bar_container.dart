import 'package:flutter/material.dart';
import 'package:foodie_finder/style/colors/colors.dart';

class AppBarContainer extends StatelessWidget implements PreferredSizeWidget {
  const AppBarContainer({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Icon(
            Icons.restaurant_menu,
            color: Color(AppColors.textColor),
            size: 40,
          ),
          Text(
            'Foodie Finder',
            style: TextStyle(
              color: Color(AppColors.textColor),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      backgroundColor: Color(AppColors.backgroundColor),
    );
  }
}

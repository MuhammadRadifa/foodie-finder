import 'package:flutter/material.dart';
import 'package:foodie_finder/presentation/shared/app_bar_container.dart';
import 'package:foodie_finder/presentation/shared/bottom_bar_container.dart';
import 'package:foodie_finder/style/colors/colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selectedTheme = 'dark'; // 'light' or 'dark'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarContainer(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose Theme',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTheme = 'light';
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: selectedTheme == 'light'
                            ? Theme.of(
                                context,
                              ).primaryColor.withValues(alpha: 0.1)
                            : Colors.grey[100],
                        border: Border.all(
                          color: selectedTheme == 'light'
                              ? Theme.of(context).primaryColor
                              : Colors.grey[300]!,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.light_mode,
                            size: 40,
                            color: selectedTheme == 'light'
                                ? Theme.of(context).primaryColor
                                : Colors.grey[600],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Light',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: selectedTheme == 'light'
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTheme = 'dark';
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: selectedTheme == 'dark'
                            ? Theme.of(context).primaryColor.withOpacity(0.1)
                            : Colors.grey[100],
                        border: Border.all(
                          color: selectedTheme == 'dark'
                              ? Theme.of(context).primaryColor
                              : Colors.grey[300]!,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.dark_mode,
                            size: 40,
                            color: selectedTheme == 'dark'
                                ? Theme.of(context).primaryColor
                                : Colors.grey[600],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Dark',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: selectedTheme == 'dark'
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBarContainer(),
    );
  }
}

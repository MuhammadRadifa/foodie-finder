import 'package:flutter/material.dart';
import 'package:foodie_finder/presentation/shared/app_bar_container.dart';
import 'package:foodie_finder/presentation/shared/bottom_bar_container.dart';
import 'package:foodie_finder/provider/local_notification_provider.dart';
import 'package:foodie_finder/provider/schedule_provider.dart';
import 'package:foodie_finder/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final isSmallScreen = screenWidth < 400;

    String selectedTheme = Provider.of<ThemeNotifier>(
      context,
      listen: false,
    ).themeMode.toString().split('.').last;

    /// langsung ambil dari provider biar real-time
    bool isAutoSchedulingEnabled = context
        .watch<ScheduleProvider>()
        .scheduleNotification;

    return Scaffold(
      appBar: AppBarContainer(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose Theme',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 16 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: isSmallScreen ? 12 : 16),

                // Theme Selection - Responsive Layout
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 300) {
                      // Stack vertically for very small screens
                      return Column(
                        children: [
                          _buildThemeOption(
                            context,
                            'light',
                            selectedTheme,
                            Icons.light_mode,
                            'Light',
                            isSmallScreen,
                          ),
                          SizedBox(height: 12),
                          _buildThemeOption(
                            context,
                            'dark',
                            selectedTheme,
                            Icons.dark_mode,
                            'Dark',
                            isSmallScreen,
                          ),
                        ],
                      );
                    } else {
                      // Side by side for larger screens
                      return Row(
                        children: [
                          Expanded(
                            child: _buildThemeOption(
                              context,
                              'light',
                              selectedTheme,
                              Icons.light_mode,
                              'Light',
                              isSmallScreen,
                            ),
                          ),
                          SizedBox(width: isSmallScreen ? 12 : 16),
                          Expanded(
                            child: _buildThemeOption(
                              context,
                              'dark',
                              selectedTheme,
                              Icons.dark_mode,
                              'Dark',
                              isSmallScreen,
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),

                SizedBox(height: isSmallScreen ? 24 : 32),

                Text(
                  'Schedule',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 16 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: isSmallScreen ? 12 : 16),

                // Schedule Section - Responsive
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!, width: 1),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.schedule,
                            size: isSmallScreen ? 20 : 24,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(width: isSmallScreen ? 8 : 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Automatic Schedule',
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 14 : 16,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge?.color,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Enable automatic scheduling for daily notifications 11 AM',
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 12 : 14,
                                    color: Colors.grey[600],
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Checkbox separated for better mobile layout
                      SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Transform.scale(
                          scale: isSmallScreen ? 0.9 : 1.0,
                          child: Checkbox(
                            value: isAutoSchedulingEnabled,
                            onChanged: (bool? value) async {
                              final localNotifProvider =
                                  Provider.of<LocalNotificationProvider>(
                                    context,
                                    listen: false,
                                  );

                              // Minta izin notifikasi
                              await localNotifProvider.requestPermissions();

                              // Baru aktifkan/disable scheduling
                              Provider.of<ScheduleProvider>(
                                // ignore: use_build_context_synchronously
                                context,
                                listen: false,
                              ).setScheduleNotification(value ?? false);
                            },
                            activeColor: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Add some bottom padding to prevent content from being hidden behind bottom nav
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomBarContainer(),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    String themeType,
    String selectedTheme,
    IconData icon,
    String label,
    bool isSmallScreen,
  ) {
    final isSelected = selectedTheme == themeType;

    return GestureDetector(
      onTap: () {
        Provider.of<ThemeNotifier>(
          context,
          listen: false,
        ).setTheme(themeType == 'light' ? ThemeMode.light : ThemeMode.dark);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
        decoration: BoxDecoration(
          color: isSelected
              ? (themeType == 'light'
                    ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
                    : Colors.white.withOpacity(0.1))
              : Colors.grey[100],
          border: Border.all(
            color: isSelected
                ? (themeType == 'light'
                      ? Theme.of(context).primaryColor
                      : Colors.white)
                : Colors.grey[300]!,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: isSmallScreen ? 32 : 40,
              color: isSelected
                  ? (themeType == 'light'
                        ? Theme.of(context).primaryColor
                        : Colors.white)
                  : Colors.grey[600],
            ),
            SizedBox(height: isSmallScreen ? 6 : 8),
            Text(
              label,
              style: TextStyle(
                fontSize: isSmallScreen ? 14 : 16,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? (themeType == 'light'
                          ? Theme.of(context).primaryColor
                          : Colors.white)
                    : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

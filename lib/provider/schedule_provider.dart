import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:foodie_finder/lib/services/local_notification_service.dart';

class ScheduleProvider with ChangeNotifier {
  bool _scheduleNotification = false;
  bool get scheduleNotification => _scheduleNotification;

  final LocalNotificationService _notificationService;

  ScheduleProvider(this._notificationService) {
    loadScheduleNotification();
  }

  Future<void> loadScheduleNotification() async {
    final prefs = await SharedPreferences.getInstance();
    _scheduleNotification = prefs.getBool('scheduleNotification') ?? false;

    // Kalau true, pastikan notif tetap dijadwalkan
    if (_scheduleNotification) {
      _notificationService.scheduleDailyElevenAMNotification(id: 1);
    }

    notifyListeners();
  }

  Future<void> setScheduleNotification(bool value) async {
    _scheduleNotification = value;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('scheduleNotification', value);

    if (value) {
      // Aktifkan notifikasi harian
      _notificationService.scheduleDailyElevenAMNotification(id: 1);
    } else {
      // Matikan notifikasi
      await flutterLocalNotificationsPlugin.cancel(1);
    }
  }
}

import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future ScheduleNotification({
  required DateTime taskDate,
  required int hour,
  required int minutes,
  required String body,
  required String title,
  required bool isPm,
}) async {

  await _configureLocalTimezone();

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings("@mipmap/ic_launcher");

  const InitializationSettings initializationSettings =
  InitializationSettings(
    android: initializationSettingsAndroid,
  );

  AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails(
    Random().nextInt(4000).toString(),
    'tasks',
    playSound: true,
    enableVibration: true,
    priority: Priority.high,
  );
  var platformChannelSpecifies = NotificationDetails(
      android: androidNotificationDetails
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  await flutterLocalNotificationsPlugin.zonedSchedule(
    Random().nextInt(4000),
    title.toString(),
    body,
    _convertTime(taskDate,hour,minutes,isPm),
    platformChannelSpecifies,
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  ).then((value) => debugPrint('Notification Pushed ' +taskDate.toString()+' ' + hour.toString() + ':' + minutes.toString()))
      .catchError((onError){debugPrint(onError.toString());});
}

Future<void> _configureLocalTimezone() async {
  tz.initializeTimeZones();
  final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZone));
}

tz.TZDateTime _convertTime(DateTime date , int hour,int minutes , bool isPm) {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  isPm ? hour += 12 :
  hour == 12 ? hour = 00: hour = hour;
  tz.TZDateTime scheduleDate =
  tz.TZDateTime(tz.local,date.year,date.month,date.day,hour,minutes);
  print('scheduleDate ' + scheduleDate.toString());
  return scheduleDate;
}
// import 'dart:math';
//
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:rxdart/rxdart.dart';
//
// class LocalNotificationManager{
//   FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin;
//   var initSettings;
//   BehaviorSubject <ReceiveNotification> get didReceiveLocalNotificationSubject => BehaviorSubject<ReceiveNotification>();
//
//   LocalNotificationManager.init(){
//      flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();
//      initializePlatform();
// }
//   initializePlatform(){
//     var initSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
//     initSettings = InitializationSettings(android: initSettingsAndroid);
//   }
//   setOnNotificationReceive(Function onNotificationReceive){
//     didReceiveLocalNotificationSubject.listen((value) {
//       onNotificationReceive(notification);
//     });
//   }
//   setOnNotificationClick(Function onNotificationClick)async{
//     await flutterLocalNotificationPlugin.initialize(initSettings,
//     onSelectNotification: (String payLoad) async {
//       onNotificationClick(payLoad)}
//     );
//
//     Future<void> showNotification() async{
//       AndroidNotificationDetails androidNotificationDetails =
//       AndroidNotificationDetails(
//         '${Random().nextInt(400)}',
//         'tasks',
//         playSound: true,
//         enableVibration: true,
//         priority: Priority.high,
//       );
//       var platformChannelSpecifies = NotificationDetails(
//           android: androidNotificationDetails
//       );
//
//       await flutterLocalNotificationPlugin.show(
//           Random().nextInt(200),
//           'asasa',
//           'fsefes',
//           platformChannelSpecifies);
//
//     }
//   }
// }
//
// class ReceiveNotification{
//   late final String id;
//   final String title;
//   final String body;
//   final String payload;
//   ReceiveNotification({ required this.id,required this.title,required this.body,required this.payload});
// }
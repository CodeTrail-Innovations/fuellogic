// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


import '../../modules/orders/models/order_model.dart';
import '../utils/utils.dart';


class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotification =
      FlutterLocalNotificationsPlugin();

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        Utils.console('User Granted Permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        Utils.console('User Granted Provisional Permission');
      }
    } else {
      AppSettings.openAppSettings();
      if (kDebugMode) {
        Utils.console('User Denied Permission');
      }
    }
  }

  void subscribeToTopic(String topic) async {
    await messaging.subscribeToTopic(topic);
    if (kDebugMode) {
      Utils.console('Subscribed to topic $topic');
    }
  }

  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitialization =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSInitialization = DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
        android: androidInitialization, iOS: iOSInitialization);
    await _flutterLocalNotification.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
      handleMessage(context, message);
    });
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      if (Platform.isAndroid) {
        initLocalNotifications(context, message);
        showNotification(message);
      } else {
        initLocalNotifications(context, message);
        showNotification(message);
      }

      if (kDebugMode) {
        Map<String, dynamic> decodedData = json.decode(message.data.toString());
        String name = decodedData['name'];
        String userName = decodedData['userName'];


        Map<String, dynamic> outerData = message.data;

        if (outerData.containsKey('data') && outerData['data'] is String) {
          Map<String, dynamic> innerData = jsonDecode(outerData['data']);
        } else {
          print('Invalid data format');
        }
      }
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    final notificationTitle = message.notification?.title ?? message.data['title'] ?? 'New Notification';
    final notificationBody = message.notification?.body ?? message.data['body'] ?? '';

    AndroidNotificationChannel androidNotificationChannel =
    AndroidNotificationChannel(Random.secure().nextInt(10000).toString(),
        'High Importance Notification',
        importance: Importance.max);

    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(androidNotificationChannel.id.toString(),
        androidNotificationChannel.name.toString(),
        channelDescription: 'iEternity channel',
        importance: Importance.high,
        priority: Priority.max,
        ticker: 'ticker');

    DarwinNotificationDetails darwinNotificationDetails =
    const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    _flutterLocalNotification.show(
      0,
      notificationTitle,
      notificationBody,
      notificationDetails,
    );
  }




  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      if (kDebugMode) {
        Utils.console('Token Refreshed');
      }
    });
  }

  Future<void> setupInteractMessage(BuildContext context) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleMessage(context, initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(context, message);
    });
  }

  Future foregroundMessage() async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    int? mediaIndex = 0;

    Map<String, dynamic> outerData = message.data;
    Map<String, dynamic> innerData = jsonDecode(outerData['data']);

    Utils.console('MESSAGE: $message');
    Utils.console('OUTER DATA: $outerData');
    Utils.console('INNER DATA: $innerData');


  }



  Future<void> sendNotificationToCustomer({
    required OrderModel order,
}) async {

    final companyId = order.companyId;
    final driverId = order.driverId;

    //from the 'device_tokens' collection, get the documents that have same docId as companyId and driverId
    //both company and driver can place their order, companyId will always be in the order, and driverId will only
    //in the case order is placed by driver, so in company order case, we only have to send notificaiton to company while in the case of
    //driver, we have to send notification to both driver and company.
    //the documents in 'device_tokens' collection have a field 'device_token' to which devices we have to send the notification
    // so now write a send notification function for this


  }

  Future<void> sendNotificationToAdmin({
    required OrderModel order,
  }) async {

    final companyId = order.companyId;
    final driverId = order.driverId;

    //this notification will be usually for new orders only.
    // first from 'users' collection, read the docs that have 'role' value 'admin' then from those docs, get the 'uid' values and save them in a list
    //because there will be multiple admins, so we have to send notificaitons to all the admins
    // once you have the uid for all admins then one by one go through the docs in 'device_tokens' and get 'device_token' for the docs that have
    //same docId as the uid and then start sending notifications
    // so now write a send notification function for this



  }






}

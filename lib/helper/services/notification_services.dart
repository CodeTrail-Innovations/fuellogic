// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


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
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    Future.delayed(Duration.zero, () {
      _flutterLocalNotification.show(0, message.notification?.title.toString(),
          message.notification?.body.toString(), notificationDetails);
    });
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

    // if (innerData[StringsResource.TYPE] ==
    //     StringsResource.NOTIFICATION_TYPE_MESSAGE) {
    //   final chat = Inbox(
    //     userId: innerData[StringsResource.USER_ID],
    //     username: innerData[StringsResource.USER_NAME],
    //     userStatus: innerData[StringsResource.USER_STATUS],
    //     lastMessage: StringsResource.STR_EMPTY_STRING,
    //     lastMessageTime: DimensionsResource.ZERO,
    //     firstName: innerData[StringsResource.NAME_NOTIFICATION_PARAMETER],
    //     lastName: StringsResource.STR_EMPTY_STRING,
    //     avatar: innerData[StringsResource.AVATAR],
    //     uuid: innerData[StringsResource.UUID],
    //     unreadCount: DimensionsResource.ZERO,
    //   );
    //
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (_) => MultiBlocProvider(
    //           providers: [
    //             BlocProvider(
    //               create: (context) => ChatBloc(),
    //             ),
    //           ],
    //           child: ChatScreen(userData: chat, isMessageListScreen: false),
    //         ),
    //       ));
    // } else if (innerData[StringsResource.TYPE] ==
    //         StringsResource.NOTIFICATION_TYPE_ADMIN_ACCESS ||
    //     innerData[StringsResource.TYPE] ==
    //         StringsResource.NOTIFICATION_TYPE_ACCESS_RESTRICTED ||
    //     innerData[StringsResource.TYPE] ==
    //         StringsResource.NOTIFICATION_TYPE_ACCESS_GRANTED ||
    //     innerData[StringsResource.TYPE] ==
    //         StringsResource.NOTIFICATION_TYPE_USER_DIED ||
    //     innerData[StringsResource.TYPE] ==
    //         StringsResource.NOTIFICATION_TYPE_ADMIN_NOTIFICATION) {
    //   Navigator.pushNamed(context, NOTIFICATIONS_SCREEN_ROUTE);
    // } else if (innerData[StringsResource.TYPE] ==
    //     StringsResource.NOTIFICATION_TYPE_CO_AUTHOR) {
    //   Navigator.pushNamed(
    //     context,
    //     POST_DETAILS_SCREEN_ROUTE,
    //     arguments: {
    //       StringsResource.STR_POST_ID: innerData[StringsResource.POST_ID],
    //       StringsResource.STR_MEDIA_INDEX: mediaIndex,
    //     },
    //   );
    // } else if (innerData[StringsResource.TYPE] ==
    //     StringsResource.NOTIFICATION_TYPE_COMMENTED) {
    //   Navigator.pushNamed(
    //     context,
    //     OWN_POST_DETAILS_SCREEN_ROUTE,
    //     arguments: innerData[StringsResource.POST_ID],
    //   );
    // } else if (innerData[StringsResource.TYPE] ==
    //         StringsResource.NOTIFICATION_TYPE_LIKED_COMMENT ||
    //     innerData[StringsResource.TYPE] ==
    //         StringsResource.NOTIFICATION_TYPE_REPLIED_COMMENT) {
    //   final userId = HiveBox().getValue(key: 'ownerId');
    //
    //   if (innerData[StringsResource.POST_OWNER_ID] == userId) {
    //     Navigator.pushNamed(
    //       context,
    //       OWN_POST_DETAILS_SCREEN_ROUTE,
    //       arguments: innerData[StringsResource.POST_ID],
    //     );
    //   } else {
    //     Navigator.pushNamed(
    //       context,
    //       POST_DETAILS_SCREEN_ROUTE,
    //       arguments: {
    //         StringsResource.STR_POST_ID: innerData[StringsResource.POST_ID],
    //         StringsResource.STR_MEDIA_INDEX: mediaIndex,
    //       },
    //     );
    //   }
    // } else if (innerData[StringsResource.TYPE] ==
    //         StringsResource.NOTIFICATION_TYPE_FRIEND_REQUEST ||
    //     innerData[StringsResource.TYPE] == 'FRIEND_REQUEST_ACCEPTED') {
    //   Navigator.pushNamed(context, OTHER_USER_PROFILE_SCREEN,
    //       arguments: innerData['senderId']);
    // }
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:onesignal_and_flutter/constants/constants.dart';
import 'package:onesignal_and_flutter/di/injector.dart';
import 'package:onesignal_and_flutter/router/router.dart';
import 'package:onesignal_and_flutter/screens/home_screen.dart';
import 'package:onesignal_and_flutter/services/awesome_notification_service.dart';
import 'package:onesignal_and_flutter/services/notification_controller.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

// global navigator key

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();

  // notification service

  await AwesomeNotificationService.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    NotificationController.actionStream();
    // NotificationController.getInstance(context).actionStream();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      title: 'Notification Example',
    );
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onesignal_and_flutter/main.dart';
import 'package:onesignal_and_flutter/statistics_page.dart';

// global navigator key

class NotificationController {
  static final AwesomeNotifications _awesomeNotifications =
      AwesomeNotifications();

  // static NotificationController? _instance;
  // NotificationController._internal(this._context);
  // static NotificationController getInstance(BuildContext context) {
  //   _instance ??= NotificationController._internal(context);
  //   return _instance!;
  // }

  NotificationController({required BuildContext context}) : _context = context;

  BuildContext _context;

  static Future<void> actionStream() async {
    _awesomeNotifications.setListeners(
        onActionReceivedMethod: onActionReceivedMethod,
        onNotificationCreatedMethod: onNotificationCreatedMethod,
        onNotificationDisplayedMethod: onNotificationDisplayedMethod,
        onDismissActionReceivedMethod: onDismissActionReceivedMethod);
  }

  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    log('onNotificationCreatedMethod...');
  }

  /// Use this method to detect every time that a new notification is displayed
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    log('onNotificationDisplayedMethod...');
  }

  /// Use this method to detect if the user dismissed a notification
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    log('onDismissActionReceivedMethod...');
  }

  /// Use this method to detect when the user taps on a notification or action button
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    log('onActionReceivedMethod...');

    final payload = receivedAction.payload;
    final action = receivedAction.actionType;
    final id = receivedAction.id;
    final channelKey = receivedAction.channelKey;
    final groupKey = receivedAction.groupKey;
    // MyApp.navigatorKey.currentState!
    //     .push(MaterialPageRoute(builder: (context) => StatisticsPage()));
    // GoRouter.of(_context).go('/statistics');
  }
}

// open page with navigator key



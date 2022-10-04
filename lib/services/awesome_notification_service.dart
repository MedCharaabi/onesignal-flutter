import 'dart:async';
import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

class NotificationWeekAndTime {
  final int dayOfTheWeek;
  final TimeOfDay timeOfDay;

  NotificationWeekAndTime({
    required this.dayOfTheWeek,
    required this.timeOfDay,
  });
}

class AwesomeNotificationService {
  // static AwesomeNotificationService? _instance;
  // AwesomeNotificationService._internal();
  // static AwesomeNotificationService getInstance() {
  //   _instance ??= AwesomeNotificationService._internal();
  //   return _instance!;
  // }

  // static AwesomeNotificationService instance() => _instance!;
  // final BuildContext _context;

  AwesomeNotificationService();

  static final AwesomeNotifications _awesomeNotifications =
      AwesomeNotifications();

  static Future<void> init() async {
    _awesomeNotifications.initialize(
      'resource://drawable/app_icon',
      [
        NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
        ),
        NotificationChannel(
          channelGroupKey: 'schedule_channel_group',
          channelKey: 'schedule_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          importance: NotificationImportance.High,
          locked: true,
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group'),
        NotificationChannelGroup(
            channelGroupKey: 'schedule_channel_group',
            channelGroupName: 'schedule group'),
      ],
      debug: true,
    );
  }

  static Future showStandardNotification({
    String? title,
    String? body,
    Map<String, String>? payload,
  }) async {
    _awesomeNotifications.createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: title,
        body: body,
        payload: payload,

        // network image
        notificationLayout: NotificationLayout.Default,
        // showWhen: true,
        // displayOnBackground: true,
      ),
    );
  }

  static Future scheduleNotification(
    String title,
    String body,
    Map<String, String>? payload, {
    required NotificationWeekAndTime dateTimeSchedule,
    bool repeat = false,
  }) async {
    String localTimeZone =
        await AwesomeNotifications().getLocalTimeZoneIdentifier();
    String utcTimeZone =
        await AwesomeNotifications().getLocalTimeZoneIdentifier();

    try {
      await _awesomeNotifications.createNotification(
        content: NotificationContent(
          id: createUniqueId(),
          channelKey: 'schedule_channel',
          title: title,
          body: body,
          payload: payload,
          // notificationLayout: NotificationLayout.Default,
        ),
        actionButtons: [
          NotificationActionButton(
            key: 'approve_taken',
            label: 'Pris',
            showInCompactView: true,
            color: Colors.grey,
            enabled: true,
          ),
          NotificationActionButton(key: 'cancel', label: 'Annuler'),
        ],
        schedule: NotificationCalendar(
          weekday: dateTimeSchedule.dayOfTheWeek,
          hour: dateTimeSchedule.timeOfDay.hour,
          minute: dateTimeSchedule.timeOfDay.minute,
          second: 0,
          millisecond: 0,
          repeats: repeat,
          allowWhileIdle: true,
        ),
        // schedule: NotificationInterval(
        //     interval: 60, timeZone: localTimeZone, repeats: repeat),
      );

      log("Notification created Successfully");
    } catch (e) {
      log('Error => $e');
    }
  }
}

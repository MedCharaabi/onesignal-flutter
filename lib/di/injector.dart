import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:onesignal_and_flutter/services/notification_controller.dart';

final locator = GetIt.instance;

setupLocator() {
  // singleton class with parameter
  // locator.registerFactory<NotificationController>(
  //     () => NotificationController(context: ));
}

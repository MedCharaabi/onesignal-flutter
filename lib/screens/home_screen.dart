import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:onesignal_and_flutter/constants/constants.dart';
import 'package:onesignal_and_flutter/screens/pay_screen.dart';
import 'package:onesignal_and_flutter/screens/paypal_pay.dart';
import 'package:onesignal_and_flutter/services/awesome_notification_service.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      Future initPushNotif() async {
        await Future.wait([
          OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none),
          OneSignal.shared.setAppId(appId),
          OneSignal.shared.setExternalUserId("1111EEE"),
          OneSignal.shared
              .promptUserForPushNotificationPermission()
              .then((accepted) {
            print("Accepted permission: $accepted");
          }),
          OneSignal.shared.getDeviceState().then((deviceState) {
            print("Device state: ${deviceState?.userId}");
          }),
        ]);
        OneSignal.shared.setSubscriptionObserver((changes) {
          if (changes.to.userId != null) {
            print("User ID changed: ${changes.to.userId}");
          }
        });
        OneSignal.shared.setNotificationWillShowInForegroundHandler(
            (OSNotificationReceivedEvent event) {
          // Will be called whenever a notification is received in foreground
          // Display Notification, pass null param for not displaying the notification
          event.complete(event.notification);
        });

        OneSignal.shared.setNotificationWillShowInForegroundHandler(
            (OSNotificationReceivedEvent event) async {
          print('FOREGROUND HANDLER CALLED WITH: ${event}');

          await AwesomeNotificationService.showStandardNotification(
            title: event.notification.title,
            body: event.notification.body,
          );

          /// Display Notification, send null to not display
          event.complete(null);
        });
      }

      initPushNotif();
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PayScreen(),
                ),
              );
            },
            icon: const Icon(Icons.payment),
          ),
        ],
      ),
      body: Center(child: Text('Home')),
      // body: PaypalPay(),
    );
  }
}

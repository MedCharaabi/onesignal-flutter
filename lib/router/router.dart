import 'package:go_router/go_router.dart';
import 'package:onesignal_and_flutter/screens/home_screen.dart';
import 'package:onesignal_and_flutter/statistics_page.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/statistics',
      builder: (context, state) => StatisticsPage(),
    ),
  ],
);

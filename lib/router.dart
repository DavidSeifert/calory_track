import 'package:calory_track/Pages/monthselectionpage.dart';
import 'package:calory_track/Pages/overviewpage.dart';
import 'package:calory_track/Pages/dayselectionpage.dart';
import 'package:calory_track/Pages/homepage.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(title: 'Calories'),
    ),
    GoRoute(
      path: '/overview',
      builder: (context, state) => OverviewPage(title: 'Overview'),
    ),
    GoRoute(
      path: '/monthselectionpage',
      builder: (context, state) =>
          Monthselectionpage(title: 'Select your Month'),
    ),
    GoRoute(
      path: '/dayselectionpage',
      builder: (context, state) =>
          Dayselectionpage(title: 'Select your Month'),
    ),
  ],
);

import 'package:calory_track/Pages/weekoverviewpage.dart';
import 'package:calory_track/Pages/overviewpage.dart';
import 'package:calory_track/Pages/weekselectionpage.dart';
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
      builder: (context, state) => WeekOverviewPage(title: 'Select your Week'),
    ),
    GoRoute(
      path: '/weekselectionpage/:week',
      builder: (context, state) {
        final week = int.parse(state.pathParameters['week']!);
        return Weekselectionpage(title: 'Week $week', weekNumber: week);
      },
    ),
  ],
);

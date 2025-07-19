import 'package:atmgo/features/home/home_screen.dart';
import 'package:atmgo/features/listbank/listbank_screen.dart';
import 'package:atmgo/features/main/main_screen.dart';
import 'package:atmgo/features/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/list',
      name: 'list',
      builder: (context, state) => const ListScreen(),
    ),
    GoRoute(
      path: '/main',
      name: 'main',
      builder: (context, state) => MainScreen(),
    ),
  ],
);

import 'package:atmgo/features/home/home_screen.dart';
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
      path: '/view_model',
      name: 'view_model',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/viewmodel',
      name: 'viewmodel',
      builder: (context, state) => MainScreen(),
    ),
  ],
);

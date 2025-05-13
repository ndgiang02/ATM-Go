import 'package:atmgo/presentation/views/home/home_screen.dart' show HomeScreen;
import 'package:atmgo/presentation/views/main/main_screen.dart';
import 'package:atmgo/presentation/views/splash/splash_screen.dart';
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
      path: '/main',
      name: 'main',
      builder: (context, state) => MainView(),
    ),
  ],
);

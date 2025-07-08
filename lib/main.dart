import 'package:atmgo/app.dart';
import 'package:atmgo/di/locator.dart';
import 'package:atmgo/features/home/view_model/home_viewmodel.dart';
import 'package:atmgo/features/main/viewmodel/main_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await dotenv.load(fileName: ".env");
  MapboxOptions.setAccessToken(dotenv.env['ACCESS_TOKEN']!);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainViewModel()),
        ChangeNotifierProvider(create: (_) => locator<HomeViewModel>()),
      ],
      child: const MyApp(),
    ),
  );
}

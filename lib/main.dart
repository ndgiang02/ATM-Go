import 'package:atmgo/app.dart';
import 'package:atmgo/presentation/view_models/home_viewmodel.dart';
import 'package:atmgo/presentation/view_models/main_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await initializeDateFormatting('vi_VN', '').then((_) =>
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeViewModel()..loadNearbyBanks(),
        ),
        ChangeNotifierProvider(create: (_) => MainViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

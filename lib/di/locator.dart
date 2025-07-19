import 'package:atmgo/data/repositories/bank_repositories_impl.dart';
import 'package:atmgo/data/repositories/location_repositories_impl.dart';
import 'package:atmgo/features/home/view_model/home_viewmodel.dart';
import 'package:atmgo/features/listbank/viewmodel/listbank_viewmodel.dart';
import 'package:atmgo/features/main/viewmodel/main_viewmodel.dart';
import 'package:atmgo/features/map/map/map_viewmodel.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<BankRepositoryImpl>(() => BankRepositoryImpl());

  locator.registerLazySingleton<LocationRepositoryImpl>(
    () => LocationRepositoryImpl(),
  );

  // locator.registerFactory(() => MainViewModel());

  locator.registerSingleton<MainViewModel>(MainViewModel());

  locator.registerFactory<HomeViewModel>(
    () => HomeViewModel(locator<LocationRepositoryImpl>()),
  );

  locator.registerFactory<MapViewModel>(
    () => MapViewModel(
      locator<LocationRepositoryImpl>(),
      locator<BankRepositoryImpl>(),
    ),
  );

  locator.registerFactory<ListViewModel>(
    () => ListViewModel(locator<BankRepositoryImpl>()),
  );
}

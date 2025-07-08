import 'package:atmgo/data/repositories/location_repositories_impl.dart';
import 'package:atmgo/features/home/view_model/home_viewmodel.dart';
import 'package:atmgo/features/main/viewmodel/main_viewmodel.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<LocationRepositoryImpl>(
    () => LocationRepositoryImpl(),
  );

  // locator.registerFactory(() => MainViewModel());

  locator.registerSingleton<MainViewModel>(MainViewModel());
  locator.registerFactory<HomeViewModel>(
    () => HomeViewModel(locator<LocationRepositoryImpl>()),
  );
}

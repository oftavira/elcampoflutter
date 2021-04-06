import 'package:get_it/get_it.dart';
import 'package:vadmin/services/navigationservice.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
}

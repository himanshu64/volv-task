import 'package:get_it/get_it.dart';
import 'package:volv/core/viewmodels/login_view_model.dart';

GetIt locator = GetIt.instance;

class LocatorInjector {
  static Future<void> setupLocator() async {
    locator.registerLazySingleton<LoginViewModel>(() => LoginViewModel());
  }
}


import 'package:get_it/get_it.dart';
import 'package:to_do_app_hive/task_app/service/task_service.dart';




final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => TaskService());
}
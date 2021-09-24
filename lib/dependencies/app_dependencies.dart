import 'package:get_it/get_it.dart';

import 'bloc_dependencies.dart';
import 'page_dependencies.dart';
class AppDependencies {
  AppDependencies._();

  static GetIt get _injector => GetIt.I;

  static Future<void> setup() async {
    await PageDependencies.setup(_injector);
    await BlocDependencies.setup(_injector);
  }
}

import 'package:demo_flutter_todo/blocs/to_do/to_do_bloc.dart';
import 'package:get_it/get_it.dart';

class BlocDependencies {
  static Future<void> setup(GetIt injector) async {
    injector.registerFactory(() => ToDoBloc());
  }
}

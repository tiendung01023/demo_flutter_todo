import 'package:demo_flutter_todo/pages/router.dart';
import 'package:demo_flutter_todo/pages/to_do/to_do_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class PageDependencies {
  static Future<void> setup(GetIt injector) async {
    injector.registerFactory<Widget>(() => const TodoPage(), instanceName: Routes.toDo);
  }
}

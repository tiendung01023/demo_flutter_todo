import 'package:demo_flutter_todo/pages/router.dart';
import 'package:flutter/material.dart';

import 'dependencies/app_dependencies.dart';

Future<void> main() async {
  await AppDependencies.setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.toDo,
      onGenerateRoute: Routes.getRoute,
    );
  }
}

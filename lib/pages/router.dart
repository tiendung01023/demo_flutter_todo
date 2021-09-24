import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

mixin Routes {
  static String get toDo => 'toDo';
  
  static PageRoute<dynamic> getRoute(RouteSettings settings) {
    Widget widget;
    try {
      widget = GetIt.I.get<Widget>(instanceName: settings.name);
    } catch (e) {
      print('[PageRoute][getRoute][Page: ${settings.name}] $e');
      widget = Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text(
            'Page [${settings.name}] not found',
          ),
        ),
      );
    }
    return MaterialPageRoute<dynamic>(builder: (_) => widget, settings: settings);
  }
}

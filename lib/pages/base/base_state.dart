import 'package:demo_flutter_todo/blocs/base/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

abstract class BaseState<T extends StatefulWidget, B extends BaseBloc<dynamic>>
    extends State<T> {
  bool _isFirstInit = true;

  late B _bloc;
  B get bloc => _bloc;

  set bloc(B? b) {
    _bloc = b ?? GetIt.I.get<B>();
  }

  @override
  void initState() {
    super.initState();
    bloc = GetIt.I.get<B>();
    bloc.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isFirstInit) {
      if (mounted) {
        final Object? args = ModalRoute.of(context)?.settings.arguments;
        onStart(context, args);
      }
      _isFirstInit = false;
    }
  }

  @mustCallSuper
  void onStart(BuildContext context, Object? payload) {
    String log = '$widget onStart';
    if (payload != null) {
      log = '$log with args: $payload';
    }
    print(log);

    bloc.onStart(context, payload);
  }

  @override
  void dispose() {
    print('$widget onDispose');
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<B>(
        create: (_) => bloc,
        child: buildContent(context),
      );
  }

  Widget buildContent(BuildContext context) => Container();
}

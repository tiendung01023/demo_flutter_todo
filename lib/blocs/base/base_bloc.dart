import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseBloc<T> extends Cubit<T> {
  late BuildContext context;

  BaseBloc(T initialState) : super(initialState);

  @mustCallSuper
  void onStart(BuildContext context, Object? payload) {
    this.context = context;
  }

  @mustCallSuper
  void initState() {}

  @mustCallSuper
  void dispose() {}
}

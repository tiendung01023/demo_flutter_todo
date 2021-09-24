import 'package:demo_flutter_todo/blocs/base/base_bloc.dart';
import 'package:demo_flutter_todo/blocs/to_do/to_do_state.dart';
import 'package:demo_flutter_todo/models/to_do_model.dart';
import 'package:demo_flutter_todo/widgets/dialog_input_widget.dart';

class ToDoBloc extends BaseBloc<ToDoState> {
  ToDoBloc() : super(ToDoState());

  Future<void> changeTab(int index) async {
    final newState = ToDoState(
      state: state,
      tabIndex: index,
    );
    emit(newState);
  }

  Future<void> addTodo() async {
    final data = await DialogInputWidget(
      title: "Add to do",
      actionTitle: "OK",
      negativeActionTitle: "Back",
      maxLines: 5,
    ).show(context);

    if (data != null) {
      final list = state.listToDo;
      list.add(ToDoModel(title: data));
      final newState = ToDoState(
        state: state,
        listToDo: list,
      );
      emit(newState);
    }
  }

  Future<void> editTodo(ToDoModel model) async {
    final data = await DialogInputWidget(
      title: "Edit to do",
      actionTitle: "OK",
      negativeActionTitle: "Back",
      maxLines: 5,
      initValue: model.title,
    ).show(context);

    if (data != null && data != model.title) {
      model.title = data;
      final newState = ToDoState(
        state: state,
      );
      emit(newState);
    }
  }

  Future<void> changeStatus(ToDoModel model) async {
    model.isDone = !model.isDone;
    final newState = ToDoState(
      state: state,
    );
    emit(newState);
  }

  Future<void> deleteTodo(ToDoModel model) async {
    final list = state.listToDo;
    list.remove(model);
    final newState = ToDoState(
      state: state,
      listToDo: list,
    );
    emit(newState);
  }
}

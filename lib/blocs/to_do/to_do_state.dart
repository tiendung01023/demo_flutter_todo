import 'package:demo_flutter_todo/models/to_do_model.dart';

class ToDoState {
  final List<ToDoModel> listToDo;
  final int tabIndex;

  List<ToDoModel> get listByTab {
    if (tabIndex == 0) return listToDo;
    return listToDo.where((element) {
      if (tabIndex == 1) {
        return element.isDone;
      } else {
        return !element.isDone;
      }
    }).toList();
  }

  ToDoState({
    ToDoState? state,
    List<ToDoModel>? listToDo,
    int? tabIndex,
  })  : listToDo = listToDo ?? state?.listToDo ?? [],
        tabIndex = tabIndex ?? state?.tabIndex ?? 0;
}

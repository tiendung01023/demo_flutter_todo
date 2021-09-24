import 'package:demo_flutter_todo/blocs/to_do/to_do_bloc.dart';
import 'package:demo_flutter_todo/blocs/to_do/to_do_state.dart';
import 'package:demo_flutter_todo/models/to_do_model.dart';
import 'package:demo_flutter_todo/pages/base/base_state.dart';
import 'package:demo_flutter_todo/pages/to_do/to_do_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends BaseState<TodoPage, ToDoBloc> {
  @override
  Widget buildContent(BuildContext context) {
    return BlocBuilder<ToDoBloc, ToDoState>(
      builder: (_, state) {
        return _buildView(state);
      },
    );
  }

  Widget _buildView(ToDoState state) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To do"),
      ),
      body: _listToDoWidget(state),
      bottomNavigationBar: _bottomNavigationBarWidget(state),
      floatingActionButton: FloatingActionButton(
        onPressed: () => bloc.addTodo(),
        child: Icon(Icons.add),
      ),
    );
  }

  ListView _listToDoWidget(ToDoState state) {
    final list = state.listByTab;
    return ListView.separated(
      separatorBuilder: (_, __) {
        return Divider();
      },
      itemCount: list.length,
      itemBuilder: (_, index) {
        final model = list.elementAt(index);
        return _toDoItemWidget(model);
      },
    );
  }

  Widget _toDoItemWidget(ToDoModel model) {
    return ToDoItemWidget(
      model: model,
      onTap: () => bloc.editTodo(model),
      onTapCheckBox: () => bloc.changeStatus(model),
      onTapDelete: () => bloc.deleteTodo(model),
    );
  }

  BottomNavigationBar _bottomNavigationBarWidget(ToDoState state) {
    return BottomNavigationBar(
      currentIndex: state.tabIndex,
      onTap: bloc.changeTab,
      items: [
        BottomNavigationBarItem(
          label: "All",
          icon: Icon(
            Icons.view_list,
          ),
        ),
        BottomNavigationBarItem(
          label: "Complete",
          icon: Icon(
            Icons.check_circle,
          ),
        ),
        BottomNavigationBarItem(
          label: "Incomplete",
          icon: Icon(
            Icons.circle_outlined,
          ),
        ),
      ],
    );
  }
}

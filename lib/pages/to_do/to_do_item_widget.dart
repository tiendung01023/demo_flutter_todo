import 'package:demo_flutter_todo/models/to_do_model.dart';
import 'package:flutter/material.dart';

class ToDoItemWidget extends StatelessWidget {
  final ToDoModel model;
  final VoidCallback onTap;
  final VoidCallback onTapCheckBox;
  final VoidCallback onTapDelete;

  const ToDoItemWidget({
    Key? key,
    required this.model,
    required this.onTap,
    required this.onTapCheckBox,
    required this.onTapDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Row(
          children: [
            Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: model.isDone,
              onChanged: (_) => onTapCheckBox(),
            ),
            Expanded(
              child: Text(
                model.title,
              ),
            ),
            IconButton(
              onPressed: () => onTapDelete(),
              icon: Icon(Icons.cancel_outlined),
            )
          ],
        ),
      ),
    );
  }
}

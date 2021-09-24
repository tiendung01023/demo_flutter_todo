import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogInputWidget extends StatefulWidget {
  final String? title;
  final String? message;

  final String? actionTitle;
  final void Function(String input)? onActionPressed;

  final String? negativeActionTitle;
  final VoidCallback? onNegativeActionPressed;

  final String Function(String input)? onValidate;

  final TextCapitalization textCapitalization; //Bàn phím hoa chữ nào
  final int? maxLength;
  final int? maxLines;
  final String? initValue;

  const DialogInputWidget({
    this.title,
    this.message,
    this.actionTitle,
    this.onActionPressed,
    this.negativeActionTitle,
    this.onNegativeActionPressed,
    this.onValidate,
    this.textCapitalization = TextCapitalization.none,
    this.maxLength,
    this.maxLines,
    this.initValue,
  });

  Future<String?> show(BuildContext context) async {
    return showCupertinoDialog<String>(
      context: context,
      builder: (_) => this,
    );
  }

  @override
  _DialogInputWidgetState createState() => _DialogInputWidgetState();
}

class _DialogInputWidgetState extends State<DialogInputWidget> {
  final controller = TextEditingController();
  String? error;

  @override
  void initState() {
    super.initState();
    controller.text = widget.initValue ?? '';
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: widget.title == null
          ? null
          : Padding(
              padding: const EdgeInsets.only(bottom: 3.0),
              child: Text(widget.title ?? ''),
            ),
      content: Card(
        color: Colors.transparent,
        elevation: 0.0,
        child: Column(
          children: <Widget>[
            if (widget.message != null) Text(widget.message!),
            const SizedBox(height: 10),
            CupertinoTextField(
              maxLength: widget.maxLength,
              textCapitalization: widget.textCapitalization,
              controller: controller,
              maxLines: widget.maxLines,
            ),
            const SizedBox(height: 2),
            Text(
              error ?? '',
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(color: Colors.red),
            )
          ],
        ),
      ),
      actions: <Widget>[
        if (widget.negativeActionTitle != null &&
            widget.negativeActionTitle!.isNotEmpty)
          CupertinoDialogAction(
            key: Key("dialog_btn_nagative"),
            isDefaultAction: true,
            onPressed: () async {
              Navigator.of(context).pop();
              await Future.delayed(const Duration(microseconds: 200));
              widget.onNegativeActionPressed?.call();
            },
            child: Text(
              widget.negativeActionTitle!,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        if (widget.actionTitle != null && widget.actionTitle!.isNotEmpty)
          CupertinoDialogAction(
            key: Key("dialog_btn_action"),
            isDefaultAction: true,
            onPressed: () async {
              error = widget.onValidate?.call(controller.text);
              if (error == null || error!.isEmpty) {
                Navigator.of(context).pop(controller.text);
                await Future.delayed(const Duration(microseconds: 200));
                widget.onActionPressed?.call(controller.text);
              } else {
                setState(() {});
              }
            },
            child: Text(
              widget.actionTitle ?? 'Đồng ý',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          )
      ],
    );
  }
}

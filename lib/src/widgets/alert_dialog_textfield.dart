import 'package:flutter/material.dart';

class AlertDialogTextField extends StatefulWidget {
  final String title;
  final VoidCallback onCompleted;
  final TextEditingController textController;
  final bool dismissOnComplete;

  const AlertDialogTextField({
    required this.title,
    required this.onCompleted,
    required this.textController,
    this.dismissOnComplete = true,
  });

  @override
  _AlertDialogTextFieldState createState() => _AlertDialogTextFieldState();
}

class _AlertDialogTextFieldState extends State<AlertDialogTextField> {
  @override
  void initState() {
    widget.textController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 20,
            ),
      ),
      content: TextField(
        controller: widget.textController,
        maxLines: 1,
        autofocus: true,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontSize: 18,
            ),
      ),
      actions: [
        TextButton(
          child: Text(
            "Cancel",
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text("Done"),
          onPressed: widget.textController.text.isEmpty
              ? null
              : () {
                  widget.onCompleted();

                  if (widget.dismissOnComplete) Navigator.pop(context);
                },
        ),
      ],
    );
  }
}

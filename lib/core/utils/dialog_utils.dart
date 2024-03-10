import 'package:flutter/material.dart';
import 'package:todo_app/core/theme/my_theme.dart';

class DialogUtils {
  static void showLoading(
      {required BuildContext context, required String message}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  width: 20,
                ),
                Text(message),
              ],
            ),
          ),
        );
      },
    );
  }

  static void hideDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void showMessage({
    required BuildContext context,
    required String message,
    String? title,
    String? posActionName,
    Function? posAction,
    String? negActionName,
    Function? negAction,
  }) {
    List<Widget> actions = [];
    if (posActionName != null) {
      actions.add(TextButton(
        // style:ElevatedButton.styleFrom(
        //   backgroundColor: MyTheme.primaryColor,
        // ),
        child: Text(
          posActionName,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: MyTheme.primaryColor,
                fontSize: 18,
              ),
        ),
        onPressed: () {
          Navigator.pop(context);
          if (posAction != null) {
            posAction.call();
          }
        },
      ));
    }
    if (negActionName != null) {
      actions.add(TextButton(
        child: Text(negActionName),
        onPressed: () {
          Navigator.pop(context);
          if (negAction != null) {
            negAction.call();
          }
        },
      ));
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          title: Text(title ?? ''),
          actions: actions,
        );
      },
    );
  }
}

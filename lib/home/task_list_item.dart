import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase/firebase_utils.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:todo_app/theme/my_theme.dart';

class TaskListItem extends StatelessWidget {
  Task task;

  TaskListItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: const EdgeInsets.all(10),
      child: Slidable(
        // Specify a key if the Slidable is dismissible.
        key: const ValueKey(0),
        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          extentRatio: 0.25,
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),
          // A pane can dismiss the Slidable.
          dismissible: DismissiblePane(onDismissed: () {}),

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              borderRadius: BorderRadius.circular(25),
              onPressed: (context) {
                // delete task
                FirebaseUtils.deleteTasksFromFireStorage(task)
                    .timeout(const Duration(milliseconds: 500), onTimeout: () {
                  print('task deleted successfully');
                  provider.getAllTasksFromFireStore();
                });
              },
              backgroundColor: MyTheme.redColor,
              foregroundColor: MyTheme.whiteColor,
              icon: Icons.delete,
              label: 'Delete',
            ),

            SlidableAction(
              borderRadius: BorderRadius.circular(25),
              onPressed: (context) {
                // delete task
                FirebaseUtils.deleteTasksFromFireStorage(task)
                    .timeout(Duration(milliseconds: 500), onTimeout: () {
                  print('task deleted successfully');
                });
              },
              backgroundColor: MyTheme.greenColor,
              foregroundColor: MyTheme.whiteColor,
              icon: Icons.edit,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          // margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: MyTheme.primaryColor),
            borderRadius: BorderRadius.circular(25),
            color: provider.isDarkMode()
                ? MyTheme.backgroundDarkColor
                : MyTheme.whiteColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                //margin: const EdgeInsets.all(5),
                color: MyTheme.primaryColor,
                height: MediaQuery.of(context).size.height * 0.10,
                width: 4,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    task.title!,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: MyTheme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    task.description!,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: provider.isDarkMode()
                              ? MyTheme.whiteColor
                              : MyTheme.blackColor,
                          fontSize: 20,
                        ),
                  ),
                ],
              )),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 7,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: MyTheme.primaryColor,
                ),
                child: Icon(
                  Icons.check,
                  color: MyTheme.whiteColor,
                  size: 30,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase/firebase_utils.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:todo_app/theme/my_theme.dart';

class TaskListItem extends StatefulWidget {
  Task task;

  TaskListItem({super.key, required this.task});

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  var selectedData = DateTime.now();
  var formKey = GlobalKey<FormState>();

  String title = '';
  String description = '';

  late AppConfigProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, EditTask.routeName);
      },
      child: Container(
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
                  FirebaseUtils.deleteTasksFromFireStorage(widget.task).timeout(
                      const Duration(milliseconds: 500), onTimeout: () {
                    print('task deleted successfully');
                    provider.getAllTasksFromFireStore();
                  });
                },
                backgroundColor: MyTheme.redColor,
                foregroundColor: MyTheme.whiteColor,
                icon: Icons.delete,
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
                          widget.task.title!,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: MyTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.task.description!,
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
      ),
    );
  }

  editTask() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.add_new_task,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: 18,
                              color: provider.isDarkMode()
                                  ? MyTheme.blackColor
                                  : MyTheme.whiteColor,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        style: TextStyle(color: MyTheme.blackColor),
                        onChanged: (text) {
                          title = text;
                        },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Please enter task title';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText:
                                AppLocalizations.of(context)!.enter_task_title,
                            hintStyle: TextStyle(
                              fontSize: 15,
                              color: provider.isDarkMode()
                                  ? MyTheme.blackColor
                                  : MyTheme.whiteColor,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        onChanged: (text) {
                          description = text;
                        },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Please enter task description';
                          }
                          return null;
                        },
                        maxLines: 4,
                        decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!
                                .enter_task_description,
                            hintStyle: TextStyle(
                              fontSize: 15,
                              color: provider.isDarkMode()
                                  ? MyTheme.blackColor
                                  : MyTheme.whiteColor,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        AppLocalizations.of(context)!.select_time,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: provider.isDarkMode()
                                  ? MyTheme.blackColor
                                  : MyTheme.whiteColor,
                              fontSize: 15,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () {
                          showCalendar();
                        },
                        child: Text(
                          '${selectedData.day}/${selectedData.month}/${selectedData.year}',
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: provider.isDarkMode()
                                        ? MyTheme.blackColor
                                        : MyTheme.whiteColor,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyTheme.primaryColor,
                          ),
                          onPressed: () {
                            String taskName = title;
                            String taskDesc = description;
                            var time = selectedData;
                            updateTask(
                                task: Task(
                                    title: taskName,
                                    description: taskDesc,
                                    dateTime: time));
                          },
                          child: Text(
                            AppLocalizations.of(context)!.save_changes,
                            style: TextStyle(
                              color: provider.isDarkMode()
                                  ? MyTheme.blackColor
                                  : MyTheme.whiteColor,
                              fontSize: 24,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void updateTask({required Task task}) {
    if (formKey.currentState?.validate() == true) {
      Task task =
          Task(title: title, description: description, dateTime: selectedData);
      // FirebaseFirestore.instance.collection(Task.collectionName).doc(
      //   widget.task.id,
      // ).update({''
      //     'id': task.id,
      //   'title': task.title,
      //   'description': task.description,
      //   'dateTime': task.dateTime,
      //
      // });
      FirebaseUtils.updateTasksInFireStorage(task);
    }
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );
  }
}

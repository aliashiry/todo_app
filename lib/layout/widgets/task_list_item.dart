import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/firebase/firebase_utils.dart';
import 'package:todo_app/core/providers/app_config_provider.dart';
import 'package:todo_app/core/providers/auth_provider.dart';
import 'package:todo_app/core/theme/my_theme.dart';
import 'package:todo_app/model/task.dart';

class TaskListItem extends StatefulWidget {
  Task task;

  TaskListItem({super.key, required this.task});

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  var selectedData = DateTime.now();
  var formKey = GlobalKey<FormState>();
  late TextEditingController taskTitleController;
  late TextEditingController taskDescriptionController;
  DateTime taskSelectedDate = DateTime.now();
  late DateTime taskSelectedTime;
  DateTime initDate = DateTime.now();
  DateTime initTime = DateTime.now();
  var id;
  late AppConfigProvider provider;
  late AuthProviders authProvider;

  @override
  void initState() {
    taskTitleController = TextEditingController();
    taskTitleController.text = 'init';
    taskDescriptionController = TextEditingController();
    taskDescriptionController.text = 'init';
    taskSelectedTime = DateTime(
      taskSelectedDate.year,
      taskSelectedDate.month,
      taskSelectedDate.day,
      TimeOfDay.now().hour,
      TimeOfDay.now().minute,
    );
    initDate = taskSelectedDate;
    initTime = taskSelectedTime;
    super.initState();
  }

  // @override
  // void dispose() {
  //   taskTitleController.dispose();
  //   taskDescriptionController.dispose();
  //   super.dispose();
  // }

  initValues(var args) {
    if (taskTitleController.text == 'init') {
      taskTitleController.text = args.title;
    }
    if (taskDescriptionController.text == 'init') {
      taskDescriptionController.text = args.description;
    }
    if (taskSelectedDate == initDate) {
      taskSelectedDate = args.date;
    }
    if (taskSelectedTime == initTime) {
      taskSelectedTime = args.time;
    }
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    authProvider = Provider.of<AuthProviders>(context);
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, EditTask.routeName);
        editTask(widget.task);
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
                  FirebaseUtils.deleteTasksFromFireStorage(
                          widget.task, authProvider.currentUser!.id!)
                      .then((value) {
                    print('task deleted successfully');
                    provider.getAllTasksFromFireStore(
                        authProvider.currentUser!.id!);
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
                  ? MyTheme.blackDarkColor
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

  editTask(Task task) {
    var selectedData = DateTime.now();
    taskTitleController.text = task.title ?? '';
    taskDescriptionController.text = task.description ?? '';
    id = task.id;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: provider.isDarkMode()
              ? MyTheme.blackDarkColor
              : MyTheme.whiteColor,
          elevation: 0,
          content: SingleChildScrollView(
            child: Container(
              color: provider.isDarkMode()
                  ? MyTheme.blackDarkColor
                  : MyTheme.whiteColor,
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
                        AppLocalizations.of(context)!.edit_task,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: 18,
                              color: provider.isDarkMode()
                                  ? MyTheme.whiteColor
                                  : MyTheme.blackColor,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        style: TextStyle(
                            color: provider.isDarkMode()
                                ? MyTheme.whiteColor
                                : MyTheme.blackColor),
                        controller: taskTitleController,
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
                                  ? MyTheme.whiteColor
                                  : MyTheme.blackColor,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        style: TextStyle(
                            color: provider.isDarkMode()
                                ? MyTheme.whiteColor
                                : MyTheme.blackColor),
                        controller: taskDescriptionController,
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
                                  ? MyTheme.whiteColor
                                  : MyTheme.blackColor,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        AppLocalizations.of(context)!.select_time,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: provider.isDarkMode()
                                  ? MyTheme.whiteColor
                                  : MyTheme.blackColor,
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
                                        ? MyTheme.whiteColor
                                        : MyTheme.blackColor,
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
                            updateTask(task: task);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.save_changes,
                            style: TextStyle(
                              color: provider.isDarkMode()
                                  ? MyTheme.whiteColor
                                  : MyTheme.blackColor,
                              fontSize: 20,
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

  void updateTask({required Task task}) async {
    if (formKey.currentState?.validate() == true) {
      // تحديث البيانات الجديدة للمهمة

      Task updatedTask = Task(
        title: taskTitleController.text,
        description: taskDescriptionController.text,
        dateTime: selectedData,
        id: id,
      );
      try {
        await FirebaseUtils.updateTask(
            updatedTask, authProvider.currentUser!.id!);
        Navigator.of(context).pop();
        provider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
      } catch (error) {
        print('Error updating task: $error');
      }
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
    if (chosenDate != null) {
      selectedData = chosenDate;
      setState(() {});
    }
  }
}

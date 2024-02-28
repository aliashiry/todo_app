import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/theme/my_theme.dart';

class EditTask extends StatelessWidget {
  static String routeName = 'edit task';

  const EditTask({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var selectedData = DateTime.now();
    var formKey = GlobalKey<FormState>();
    TextEditingController? title;
    TextEditingController? description;

    return Container(
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
                controller: title,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please enter task title';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.enter_task_title,
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
               controller: description,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please enter task description';
                  }
                  return null;
                },
                maxLines: 4,
                decoration: InputDecoration(
                    hintText:
                        AppLocalizations.of(context)!.enter_task_description,
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
                  //showCalendar();
                },
                child: Text(
                  '${selectedData.day}/${selectedData.month}/${selectedData.year}',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
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
                    //  updateTask(task: Task(title: taskName, description: taskDesc, dateTime: time));
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
    );
  }
}

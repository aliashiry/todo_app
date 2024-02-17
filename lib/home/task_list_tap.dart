import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/home/task_list_item.dart';
import 'package:todo_app/theme/my_theme.dart';

import '../providers/app_config_provider.dart';

class TaskListTab extends StatefulWidget {
  const TaskListTab({super.key});

  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    EasyInfiniteDateTimelineController();
    DateTime? focusDate = DateTime.now();
    return Container(
      color: provider.isDarkMode()
          ? MyTheme.backgroundDarkColor
          : MyTheme.whiteColor,
      child: Column(
        children: [
          EasyDateTimeLine(
            headerProps: EasyHeaderProps(
                monthStyle: TextStyle(
              color: provider.isDarkMode() ? Colors.white : Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            )),
            initialDate: DateTime.now(),
            onDateChange: (selectedDate) {
              //`selectedDate` the new date selected.
              focusDate = selectedDate;
            },
            activeColor: MyTheme.primaryColor,
            locale: provider.appLanguage == "en" ? "en" : "ar",
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(itemBuilder: (context, index) {
              return const TaskListItem();
            }),
          )
        ],
      ),
    );
  }
}

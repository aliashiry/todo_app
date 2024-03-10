import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/providers/app_config_provider.dart';
import 'package:todo_app/core/providers/auth_provider.dart';
import 'package:todo_app/core/theme/my_theme.dart';
import 'package:todo_app/layout/widgets/task_list_item.dart';

class TaskListTab extends StatelessWidget {
  const TaskListTab({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var authProvider = Provider.of<AuthProviders>(context);
    if (provider.tasksList.isEmpty) {
      provider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
    }
    return Container(
      color: provider.isDarkMode()
          ? MyTheme.backgroundDarkColor
          : MyTheme.backgroundColor,
      child: Column(
        children: [
          EasyDateTimeLine(
            headerProps: const EasyHeaderProps(
                monthStyle: TextStyle(color: Colors.black)),
            initialDate: provider.selectedDate,
            onDateChange: (data) {
              provider.changeSelectedData(data, authProvider.currentUser!.id!);
            },
            activeColor: provider.isDarkMode()
                ? MyTheme.primaryColor
                : MyTheme.primaryColor,
            dayProps: EasyDayProps(
              todayHighlightStyle: TodayHighlightStyle.withBackground,
              inactiveDayStyle: DayStyle(
                dayStrStyle: TextStyle(
                    color: provider.isDarkMode()
                        ? MyTheme.whiteColor
                        : MyTheme.blackColor),
                monthStrStyle: TextStyle(
                    color: provider.isDarkMode()
                        ? MyTheme.whiteColor
                        : MyTheme.blackColor),
                dayNumStyle: TextStyle(
                    color: provider.isDarkMode()
                        ? MyTheme.whiteColor
                        : MyTheme.blackColor),
                decoration: BoxDecoration(
                  color: provider.isDarkMode()
                      ? MyTheme.blackDarkColor
                      : MyTheme.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            locale: provider.appLanguage,
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return TaskListItem(task: provider.tasksList[index]);
              },
              itemCount: provider.tasksList.length,
            ),
          )
        ],
      ),
    );
  }
}

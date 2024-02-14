import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/home/task_list_item.dart';
import 'package:todo_app/theme/my_theme.dart';

class TaskListTab extends StatefulWidget {
  const TaskListTab({super.key});

  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  @override
  Widget build(BuildContext context) {
    final EasyInfiniteDateTimelineController _controller =
        EasyInfiniteDateTimelineController();
    DateTime? _focusDate = DateTime.now();
    return Container(
      child: Column(
        children: [
          EasyDateTimeLine(
            headerProps: const EasyHeaderProps(
                monthStyle: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            )),
            initialDate: DateTime.now(),
            onDateChange: (selectedDate) {
              //`selectedDate` the new date selected.
              _focusDate = selectedDate;
            },
            activeColor: MyTheme.primaryColor,
            locale: "en",
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(itemBuilder: (context, index) {
              return TaskListItem();
            }),
          )
        ],
      ),
    );
  }
}

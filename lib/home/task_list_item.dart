import 'package:flutter/material.dart';
import 'package:todo_app/theme/my_theme.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: MyTheme.whiteColor,
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
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Task',
                style: Theme.of(context)?.textTheme.titleMedium?.copyWith(
                      color: MyTheme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                'Des',
                style: Theme.of(context)?.textTheme.titleMedium?.copyWith(
                      color: MyTheme.blackColor,
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
    );
  }
}

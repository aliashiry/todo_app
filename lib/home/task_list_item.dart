import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:todo_app/theme/my_theme.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: const EdgeInsets.all(10),
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
                AppLocalizations.of(context)!.task,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: MyTheme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
                  Text(
                AppLocalizations.of(context)!.description,
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
    );
  }
}

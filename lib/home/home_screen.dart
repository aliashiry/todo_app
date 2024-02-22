import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/home/add_task_bottomsheet.dart';
import 'package:todo_app/home/settings_tap.dart';
import 'package:todo_app/home/task_list_tap.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:todo_app/theme/my_theme.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home-screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      backgroundColor: provider.isDarkMode()
          ? MyTheme.backgroundDarkColor
          : MyTheme.backgroundColor,
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.19,
        title: Text(
          AppLocalizations.of(context)!.app_title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 1),
        height: MediaQuery.of(context).size.height * 0.08,
        shadowColor: provider.isDarkMode()
            ? MyTheme.backgroundDarkColor
            : MyTheme.whiteColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        color: provider.isDarkMode()
            ? MyTheme.backgroundDarkColor
            : MyTheme.whiteColor,
        child: BottomAppBar(
          color: provider.isDarkMode()
              ? MyTheme.backgroundDarkColor
              : Colors.white12,
          padding: const EdgeInsets.symmetric(horizontal: 0),
          elevation: 0,
          notchMargin: 10,
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            currentIndex: selectedIndex,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                  color: provider.isDarkMode() ? Colors.white : Colors.black,
                ),
                label: AppLocalizations.of(context)!.task_list,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings,
                    color: provider.isDarkMode() ? Colors.white : Colors.black),
                label: AppLocalizations.of(context)!.settings,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyTheme.primaryColor,
        onPressed: () {
          showAddBottomSheet();
        },
        child: Icon(
          Icons.add,
          color: MyTheme.whiteColor,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: selectedIndex == 0 ? const TaskListTab() : const SettingsTab(),
    );
  }

  void showAddBottomSheet() {
    showModalBottomSheet(
        // shape:RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
        context: context,
        builder: (context) => const AddTaskBottomSheet());
  }
}

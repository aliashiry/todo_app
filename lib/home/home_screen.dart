import 'package:flutter/material.dart';
import 'package:todo_app/home/add_task_bottomsheet.dart';
import 'package:todo_app/home/settings_tap.dart';
import 'package:todo_app/home/task_list_tap.dart';
import 'package:todo_app/theme/my_theme.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home-screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.19,
        title: Text(
          'ToDo List',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        height: MediaQuery.of(context).size.height * 0.08,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: MyTheme.whiteColor,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Task List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // backgroundColor: MyTheme.primaryColor,
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
        context: context, builder: (context) => const AddTaskBottomSheet());
  }
}

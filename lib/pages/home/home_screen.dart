import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/providers/app_config_provider.dart';
import 'package:todo_app/core/providers/auth_provider.dart';
import 'package:todo_app/core/theme/my_theme.dart';
import 'package:todo_app/layout/widgets/add_task_bottomsheet.dart';
import 'package:todo_app/layout/widgets/settings_tap.dart';
import 'package:todo_app/layout/widgets/task_list_tap.dart';
import 'package:todo_app/pages/auth/login_screen_view//login_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home-screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  var selectedData = DateTime.now();
  String title = '';
  String description = '';
  late AppConfigProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    var authProvider = Provider.of<AuthProviders>(context);
    return Scaffold(
      backgroundColor: provider.isDarkMode()
          ? MyTheme.backgroundDarkColor
          : MyTheme.backgroundColor,
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.19,
        title: Text(
          '${AppLocalizations.of(context)!.app_title} ${authProvider.currentUser?.name}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: MyTheme.whiteColor,
            ),
            onPressed: () {
              provider.tasksList = [];
              authProvider.currentUser = null;
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 1),
        height: MediaQuery.of(context).size.height * 0.08,
        shadowColor:
            provider.isDarkMode() ? MyTheme.blackDarkColor : MyTheme.whiteColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        color:
            provider.isDarkMode() ? MyTheme.blackDarkColor : MyTheme.whiteColor,
        child: BottomAppBar(
          color: provider.isDarkMode() ? MyTheme.blackDarkColor : Colors.white12,
          padding: const EdgeInsets.symmetric(horizontal: 0),
          elevation: 0,
          notchMargin: 10,
          child: BottomNavigationBar(
            elevation: 0,
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
        context: context,
        builder: (context) => const AddTaskBottomSheet());
  }
}

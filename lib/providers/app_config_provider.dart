import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/firebase/firebase_utils.dart';
import 'package:todo_app/model/task.dart';

class AppConfigProvider extends ChangeNotifier {
  AppConfigProvider(bool isDark) {
    if (isDark) {
      appTheme = ThemeMode.dark;
    } else {
      appTheme = ThemeMode.light;
    }
  }

  List<Task> tasksList = [];
  DateTime selectedDate = DateTime.now();
  String appLanguage = 'en';
  ThemeMode appTheme = ThemeMode.light;

  void changeLanguage(String newLanguage) {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();
  }

  void changeThemeMode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (appTheme == ThemeMode.light) {
      appTheme = ThemeMode.dark;
      sharedPreferences.setBool('is_dark', true);
      return;
    }
    appTheme = ThemeMode.light;
    sharedPreferences.setBool('is_dark', false);
    notifyListeners();
  }

  bool isDarkMode() {
    return appTheme == ThemeMode.dark;
  }

  void getAllTasksFromFireStore() async {
    QuerySnapshot<Task> querySnapshot =
    await FirebaseUtils.getTasksCollection().get();
    tasksList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    tasksList = tasksList.where((task) {
      if (selectedDate.day == task.dateTime?.day &&
          selectedDate.month == task.dateTime?.month &&
          selectedDate.year == task.dateTime?.year) {
        return true;
      }
      return false;
    }).toList();
    tasksList.sort((task1, task2) {
      return task1.dateTime!.compareTo(task2.dateTime!);
    });
    notifyListeners();
  }

  void changeSelectedData(DateTime newSelected) {
    selectedDate = newSelected;
    getAllTasksFromFireStore();
    notifyListeners();
  }
}

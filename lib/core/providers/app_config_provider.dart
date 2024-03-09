import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/firebase/firebase_utils.dart';
import 'package:todo_app/model/task.dart';

class AppConfigProvider extends ChangeNotifier {
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

  void changeThemeMode(ThemeMode newThemeMode) {
    if (appTheme == newThemeMode) {
      return;
    }
    appTheme = newThemeMode;
    notifyListeners();
  }

  bool isDarkMode() {
    return appTheme == ThemeMode.dark;
  }

  void getAllTasksFromFireStore(String uId) async {
    QuerySnapshot<Task> querySnapshot =
        await FirebaseUtils.getTasksCollection(uId).get();
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

  void changeSelectedData(DateTime newSelected, String uId) {
    selectedDate = newSelected;
    getAllTasksFromFireStore(uId);
  }
}
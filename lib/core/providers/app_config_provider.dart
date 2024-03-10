import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/firebase/firebase_utils.dart';
import 'package:todo_app/model/task.dart';

class AppConfigProvider extends ChangeNotifier {
  List<Task> tasksList = [];
  DateTime selectedDate = DateTime.now();
  String appLanguage = 'en';
  ThemeMode appTheme = ThemeMode.light;

  Future<void> changeLanguage(String newLanguage) async {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', newLanguage);
  }

  Future<void> changeThemeMode(ThemeMode newThemeMode) async {
    if (appTheme == newThemeMode) {
      return;
    }
    appTheme = newThemeMode;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', newThemeMode == ThemeMode.dark);
  }

  Future<void> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lang = prefs.getString('lang');
    if (lang != null) {
      appLanguage = lang;
      notifyListeners();
    }
  }

  Future<void> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isDark = prefs.getBool('isDark');
    if (isDark != null) {
      if (isDark) {
        appTheme = ThemeMode.dark;
      } else {
        appTheme = ThemeMode.light;
      }
      notifyListeners();
    }
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

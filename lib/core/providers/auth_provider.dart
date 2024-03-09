import 'package:flutter/cupertino.dart';
import 'package:todo_app/model/user.dart';

class AuthProviders extends ChangeNotifier {
  MyUser? currentUser;

  void updateUser(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}

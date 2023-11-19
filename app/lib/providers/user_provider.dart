
import 'package:app/model/user.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  late User _user;

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
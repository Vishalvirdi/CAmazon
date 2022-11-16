import 'package:flutter/material.dart';
import 'package:submart/Resources/cloud_methods.dart';
import 'package:submart/models/user_model.dart';

class UserDetailsProvider with ChangeNotifier {
  UserDetailsModel userDetails;

  UserDetailsProvider()
      : userDetails = UserDetailsModel(
            name: "Vishal Virdi", address: "Hoshiarpur,Punjab");

  Future getData() async {
    userDetails = await CloudFirestoreClass().getNameAndAddress();
    notifyListeners();
  }
}

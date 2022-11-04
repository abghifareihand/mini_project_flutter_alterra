import 'package:flutter/material.dart';
import 'package:mini_project_flutter_alterra/models/restaurant_model.dart';

class ContactProvider with ChangeNotifier {
  final _contacts = <RestaurantModel>[];
  List<RestaurantModel> get contacts => _contacts;

  void addContact(RestaurantModel contact) { // fungsi add contact
    _contacts.add(contact);
    notifyListeners();
  }

  void deleteContact(int index) { // fungsi delete contact
    _contacts.removeAt(index);
    notifyListeners();
  }
}
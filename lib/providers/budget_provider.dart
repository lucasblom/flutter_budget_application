import 'package:flutter/material.dart';

class BudgetProvider extends ChangeNotifier {
  double _budget = 0;

  double get budget => _budget;

  void setBudget(double budget) {
    _budget = budget;
    notifyListeners();
  }

  void resetBudget() {
    _budget = 0;
    notifyListeners();
  }
}
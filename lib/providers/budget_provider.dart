import 'package:flutter/material.dart';
import 'package:flutter_budget_application/services/budget_service.dart';

class BudgetProvider extends ChangeNotifier {
  final BudgetService _budgetService = BudgetService();
  double _budget = 69.69;

  double get budget => _budget;

  BudgetProvider() {
    _loadBudget();
  }

  Future<void> _loadBudget() async {
    await _budgetService.load();
    _budget = _budgetService.budget.amount;
    notifyListeners();
  }

  Future<void> setBudget(double budget) async {
    _budget = budget;
    await _budgetService.updateBudget(budget);
    notifyListeners();
  }

  Future<void> resetBudget() async {
    _budget = 69;
    await _budgetService.updateBudget(_budget);
    notifyListeners();
  }
}

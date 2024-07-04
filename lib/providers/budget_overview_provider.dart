import 'package:flutter/material.dart';
import 'package:flutter_budget_application/model/expense.dart';
import 'package:flutter_budget_application/services/expense_service.dart';


class ExpenseOverview extends ChangeNotifier {
  ExpenseOverview(this._expenseService);

  List<Expense> get expenses => _expenseService.readAll();

  void addCookie(String name, String category, double amount) {
    _expenseService
    .create(Expense(name, category, amount))
    .then((_) => notifyListeners());
  }

  void deleteCookie(String name) {
    _expenseService
    .delete(name)
    .then((_) => notifyListeners());
  }


  final ExpenseService _expenseService;
  
}
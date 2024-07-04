

import 'package:flutter_budget_application/model/expense.dart';

/// Implements CRUD functionality for cookies.
class ExpenseService {
  Future<void> create(Expense expense) async{
    _expenses.insert(0, expense);
    return _save();
  }


  List<Expense> readAll() {
    return List.unmodifiable(_expenses);
  }


  Future<void> update(String name, String category, double amount) async{}


  Future<void> delete(String name) async{
    _expenses.removeWhere((expense) => expense.name == name);
    return _save();
  }

  //! Call load() once before using the service
  Future<void> load() async {
    // todo : should load from a database or file
    _expenses = _fakeExpenseData;
    return Future.delayed(const Duration(milliseconds: 500));
  }


  Future<void> _save() async{
    // todo : should save to a database or file
  }
  List<Expense> _expenses = [];
}

List<Expense> _fakeExpenseData = [
  Expense("Shoes", "Clothing", 200), 
  Expense("Food","Groceries", 250), 
  Expense("Train Ticket", "Transportation", 50),
];
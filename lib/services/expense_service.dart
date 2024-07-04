import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_budget_application/model/expense.dart';

/// Implements CRUD functionality for expenses.
class ExpenseService {
  static const String _prefsKey = 'expenses';

  Future<void> create(Expense expense) async {
    _expenses.insert(0, expense);
    return _save();
  }

  List<Expense> readAll() {
    return List.unmodifiable(_expenses);
  }

  Future<void> delete(String name) async {
    _expenses.removeWhere((expense) => expense.name == name);
    return _save();
  }

  //! Call load() once before using the service
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_prefsKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      _expenses = jsonList.map((json) => Expense.fromJson(json)).toList();
    } else {
      _expenses = _fakeExpenseData;
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(_expenses.map((expense) => expense.toJson()).toList());
    await prefs.setString(_prefsKey, jsonString);
  }

  List<Expense> _expenses = [];
}

List<Expense> _fakeExpenseData = [
  Expense("Shoes", "Clothing", 200),
  Expense("Food", "Groceries", 250),
  Expense("Train Ticket", "Transportation", 50),
];

// Assuming Expense class has toJson and fromJson methods.
extension ExpenseSerialization on Expense {
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'amount': amount,
    };
  }

  static Expense fromJson(Map<String, dynamic> json) {
    return Expense(
      json['name'] as String,
      json['category'] as String,
      json['amount'] as double,
    );
  }
}

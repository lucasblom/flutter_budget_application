import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/budget.dart';

class BudgetService {
  static const String _prefsKey = 'budget';

  BudgetService() {
    _initialize();
  }

  Future<void> _initialize() async {
    await load();
  }

  Future<void> updateBudget(double amount) async {
    _budget = Budget(amount);
    await _save();
  }

  Budget get budget => _budget;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance(); //!AHHHHHHHHHHHHHHHH
    final jsonString = prefs.getString(_prefsKey);
    if (jsonString != null) {
      final Map<String, dynamic> json = jsonDecode(jsonString);
      _budget = Budget.fromJson(json);
    } else {
      // !Default value if no budget is saved
      _budget = Budget(1000); 
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(_budget.toJson());
    await prefs.setString(_prefsKey, jsonString);
  }

  late Budget _budget;
}
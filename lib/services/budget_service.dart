
import 'package:flutter_budget_application/model/budget.dart';

class BudgetService {

  Future<void> updateBudget(double budget) async {
    _budget = budget;
  }

  double _budget = 1000;
}


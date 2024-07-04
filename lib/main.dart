
import 'package:flutter/material.dart';
import 'package:flutter_budget_application/pages/budget_overview.dart';
import 'package:flutter_budget_application/providers/budget_overview_provider.dart';
import 'package:flutter_budget_application/providers/budget_provider.dart';
import 'package:flutter_budget_application/services/budget_service.dart';
import 'package:flutter_budget_application/services/expense_service.dart';
import 'package:provider/provider.dart';

void main() async {
  final budgetService = BudgetService();
  await budgetService.load(); // Load the budget from SharedPreferences
  ExpenseService service = ExpenseService();
  await service.load();
  var expensesOverview = ExpenseOverview(service);
  var budgetProvider = BudgetProvider();

 runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => expensesOverview),
    ChangeNotifierProvider(create: (_) => budgetProvider),
    ], 
  child: const ExpensesApp(),
  ),
  );
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ExpenseOverviewPage()// CookieOfTheDayPage(),
    );
  }
}
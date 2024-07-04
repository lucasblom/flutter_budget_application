// ignore_for_file: use_key_in_widget_constructors
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_budget_application/model/expense.dart';
import 'package:flutter_budget_application/pages/adding_expenses.dart';
import 'package:flutter_budget_application/pages/budget_settings.dart';
import 'package:flutter_budget_application/providers/budget_overview_provider.dart';
import 'package:flutter_budget_application/providers/budget_provider.dart';
import 'package:provider/provider.dart';

class ExpenseOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => BudgetSettings()));
                },
              ),
              const Text('Expense Overview', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ]
          ),
        )
      ),
      body: Column(
        children: [
          BudgetSummary(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            const Text("   Expenses: ", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), // DO NOT TOUCH THIS LINE "   " are !IMPORTANT
            IconButton(
                icon: const Icon(Icons.add),
                padding: const EdgeInsets.only(right: 10),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddingExpenses(),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(child: _ExpenseList()),
        ],
      ),
    );
  }
}

class _ExpenseList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var expenses = Provider.of<ExpenseOverview>(context).expenses;

    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(expenses[index].name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal)),
          subtitle: Text("-   ${expenses[index].category}"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(expenses[index].amount.toStringAsFixed(2), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  Provider.of<ExpenseOverview>(context, listen: false)
                      .deleteExpense(expenses[index].name);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ExpenseEdit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExpenseEditState();
}

class _ExpenseEditState extends State<_ExpenseEdit> {
  final _wisdomController = TextEditingController();
  final _authorController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _wisdomController,
            decoration: const InputDecoration(labelText: "Name"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _authorController,
            decoration: const InputDecoration(labelText: "Category"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _amountController,
            decoration: const InputDecoration(labelText: "Amount"),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Provider.of<ExpenseOverview>(context, listen: false).addExpense(
              _wisdomController.text,
              _authorController.text,
              double.parse(_amountController.text),
            );
            _wisdomController.clear();
            _authorController.clear();
            _amountController.clear();
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}

class BudgetSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var budget = Provider.of<BudgetProvider>(context).budget;
    var expenses = Provider.of<ExpenseOverview>(context).expenses;
    var categoryTotals = _calculateCategoryTotals(expenses);
    double total = 0;
    var bg_green = const Color.fromRGBO(105, 176, 155, 1);
    var bg_red = Color.fromARGB(255, 175, 86, 86);

    for (var expense in expenses) {
      total += expense.amount;
    }
    if (budget <= total) {
      return Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 16),
        color: bg_red,
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      sections: getSections(categoryTotals),
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 0,
                      centerSpaceRadius: 60, // Create space in the center
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      budget.toString(), // Display the budget here
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 50,
                      height: 1,
                      color: const Color.fromARGB(255, 0, 0, 0), // Thin horizontal line
                    ),
                    const SizedBox(height: 4),
                    Text(
                      total.toString(), // Display the remaining budget here
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      color: bg_green,
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    sections: getSections(categoryTotals),
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0,
                    centerSpaceRadius: 60, // Create space in the center
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    budget.toString(), // Display the budget here
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 50,
                    height: 1,
                    color: const Color.fromARGB(255, 0, 0, 0), // Thin horizontal line
                  ),
                  const SizedBox(height: 4),
                  Text(
                    total.toString(), // Display the remaining budget here
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> getSections(Map<String, double> categoryTotals) {
    List<Color> colors = [Colors.blue, Colors.red, Colors.green, Colors.orange, Colors.purple];
    int colorIndex = 0;

    return categoryTotals.entries.map((entry) {
      final color = colors[colorIndex % colors.length];
      colorIndex++;
      return PieChartSectionData(
        color: color,
        value: entry.value,
        title: entry.key,
        radius: 40,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  Map<String, double> _calculateCategoryTotals(List<Expense> expenses) {
    Map<String, double> categoryTotals = {};

    for (var expense in expenses) {
      if (!categoryTotals.containsKey(expense.category)) {
        categoryTotals[expense.category] = 0.0;
      }
      if (categoryTotals[expense.category] != null) {categoryTotals[expense.category] = categoryTotals[expense.category]! + expense.amount;}
      else {categoryTotals[expense.category] = expense.amount;}
    }

    return categoryTotals;
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;

  const Indicator({
    super.key,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}

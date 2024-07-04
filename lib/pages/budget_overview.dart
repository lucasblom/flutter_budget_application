// ignore_for_file: use_key_in_widget_constructors
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_budget_application/model/expense.dart';
import 'package:flutter_budget_application/pages/budget_settings.dart';
import 'package:flutter_budget_application/providers/budget_overview_provider.dart';
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
              FloatingActionButton.small(
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const BudgetSettings()));
                },
                child: const Icon(Icons.settings),
              ),
              const Text('Expense Overview', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              FloatingActionButton.small(
                backgroundColor: Colors.white,
                onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => _ExpenseEdit()));
              },
              child: const Icon(Icons.add),
              )
            ]
          ),
        )
      ),
      body: Column(
        children: [
          BudgetSummary(),
          const SizedBox(height: 16),
          const Text("Expenses: ", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
                      .deleteCookie(expenses[index].name);
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
            Provider.of<ExpenseOverview>(context, listen: false).addCookie(
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
    var expenses = Provider.of<ExpenseOverview>(context).expenses;
    var categoryTotals = _calculateCategoryTotals(expenses);
    double total = 0;

    for (var expense in expenses) {
      total += expense.amount;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      color: const Color.fromRGBO(105, 176, 155, 1),
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
                    'CHF 1000${categoryTotals != 0.0 ? '' : ''}', // Display the total budget here
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

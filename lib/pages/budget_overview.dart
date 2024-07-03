// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_budget_application/pages/adding_expenses.dart';
import 'package:flutter_budget_application/pages/budget_settings.dart';

class BudgetOverview extends StatelessWidget {
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BudgetSettings()), // Replace NewPage with your actual page class
                  );
                }, 
                child: const Icon(Icons.settings)
              ),
              const Text('Budget Overview', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              FloatingActionButton.small(
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddingExpenses()), // Replace NewPage with your actual page class
                  );
                }, 
                child: const Icon(Icons.add)
              ),
            ],
          )
          //Text('Budget Overview'),
        ),
      ),
      body: Column(
        children: <Widget>[
          BudgetHeader(),
          BudgetSummary(),
          const Text('Expenses', 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
          BudgetExpenses(),
        ],
      ),
    );
  }
}

/// The header of the budget overview
/// Displays the budget for the month and the remaining budget
class BudgetHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color.fromRGBO(105, 176, 155, 1),
      child: const Column(
        children: <Widget>[
          Row(), // Placeholder for the Diagram
          Row(
            children: <Widget>[
              Text('Budget for the Month', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Spacer(),
              Text('CHF 1000', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            children: <Widget>[
              Text('Remaining Budget', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
              Spacer(),
              Text('CHF 500', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
            ],
          ),
        ],
      ),
    );
  }
}

/// Shows a pie diagram of the budget
/// The diagram is a circle with a hole in the middle
/// The hole is filled with the color of the background and the Budget is displayed in the middle
class BudgetSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    sections: getSections(),
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0,
                    centerSpaceRadius: 60, // Create space in the center
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'CHF 1000', // Display the total budget here
                    style: TextStyle(
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
                  const Text(
                    'CHF 500', // Display the remaining budget here
                    style: TextStyle(
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

  List<PieChartSectionData> getSections() {
    return [
      PieChartSectionData(
        color: Colors.blue,
        value: 40,
        title: 'Clothing',
        radius: 40,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: 30,
        title: 'Groceries',
        radius: 40,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.green,
        value: 15,
        title: 'Transportation',
        radius: 40,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.orange,
        value: 15,
        title: 'Other',
        radius: 40,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];
  }
}

/// Displays each expense of the month
/// The expenses are displayed in a list
/// Each expense has a category and the amount
class BudgetExpenses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9, // Set width to 90% of the parent
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(160, 205, 211, 1),
          borderRadius: BorderRadius.circular(12), // Add rounded corners
        ),
        child: const Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Shoes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                Spacer(),
                Text('CHF 200', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              children: <Widget>[
                Text('Clothing', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
              ],
            ),
          ],
        ),
      ),
    );
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

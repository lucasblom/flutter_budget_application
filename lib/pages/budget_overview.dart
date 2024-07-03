// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BudgetOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(105, 176, 155, 1),
        title: const Align(
          alignment: Alignment.center,
          child: Text('Budget Overview'),
        ),
      ),
      body: Column(
        children: <Widget>[
          BudgetSummary(),
          BudgetHeader(),
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
                    centerSpaceRadius: 70, // Create space in the center
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'CHF 1000', // Display the total budget here
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  Container(
                    width: 50,
                    height: 1,
                    color: Colors.black, // Thin horizontal line
                  ),

                  const Text(
                    'CHF 500', // Display the remaining budget here
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Indicator(color: Colors.blue, text: 'Category A'),
                  SizedBox(width: 8),
                  Indicator(color: Colors.red, text: 'Category B'),
                  SizedBox(width: 8),
                  Indicator(color: Colors.green, text: 'Category C'),
                  SizedBox(width: 8),
                  Indicator(color: Colors.orange, text: 'Category D'),
                ],
              ),
              ]
          )
        ],
      ),
    );
  }

  List<PieChartSectionData> getSections() {
    return [
      PieChartSectionData(
        color: Colors.blue,
        value: 40,
        title: '40%',
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
        title: '30%',
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
        title: '15%',
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
        title: '15%',
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
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16), 
        color: const Color.fromRGBO(160, 205, 211, 1),// Round the corners
      ),
      child: const Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('Expenses', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
              Spacer(),
              Text('CHF 500', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            children: <Widget>[
              Text('Category', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
            ],
          ),
        ],
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
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}

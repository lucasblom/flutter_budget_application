import 'package:flutter/material.dart';
import 'package:flutter_budget_application/pages/budget_overview.dart';

class BudgetSettings extends StatefulWidget {
  const BudgetSettings({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BudgetSettingsState createState() => _BudgetSettingsState();
}

class _BudgetSettingsState extends State<BudgetSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Row(
            children: <Widget>[
              const Padding(padding: EdgeInsets.only(right: 5)),
              FloatingActionButton.small(
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BudgetOverview()));
                },
                child: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              const SizedBox(width: 15),
              const Text('Settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        )
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FractionallySizedBox(
            alignment: Alignment.center,
            widthFactor: 0.9, 
            child: Column(              
              children: <Widget>[
                const Text('Set your budget for the month', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    labelText: 'Budget',
                    labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Save the budget
                  },
                  child: const Text('Save'),
                ),
              ]
            ),
          ),
        ],
      ),
    );
  }
}
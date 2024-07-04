import 'package:flutter/material.dart';
import 'package:flutter_budget_application/pages/budget_overview.dart';
import 'package:flutter_budget_application/providers/budget_provider.dart';
import 'package:provider/provider.dart';

class BudgetSettings extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    var budget = Provider.of<BudgetProvider>(context).budget;
    return Scaffold(

      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton.small(
                backgroundColor: Colors.white,
                onPressed: () {
                  // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext) => BudgetSettings())); 
                },
                child: const Icon(Icons.settings),
              ),
              const Text('Budget Settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              FloatingActionButton.small(
                backgroundColor: Colors.white,
                onPressed: () {
                  // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext) => ExpenseOverviewPage())); 
                },
                child: const Icon(Icons.arrow_forward_ios_rounded),
              ),],
          ),
        ) 
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment. center,
            children: [
              Column(
                children: [
                  const Text("Budget:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
                  const SizedBox(height: 5),
                  Text(budget.toString(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  FloatingActionButton.small(
                    backgroundColor: Colors.white,
                    onPressed: () {
                      Provider.of<BudgetProvider>(context, listen: false).resetBudget();
                    },
                    child: const Icon(Icons.refresh),
                  ),
                ],
              )
            ],
          ),
          _BudgetEdit(),
        ],
      ),
    );
  }
}

class _BudgetEdit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BudgetEditState();
}

class _BudgetEditState extends State<_BudgetEdit> {
  final _budgetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _budgetController,
            decoration: const InputDecoration(labelText: "Amount"),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Provider.of<BudgetProvider>(context, listen: false).setBudget(
              double.parse(_budgetController.text),
            );
            _budgetController.clear();
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
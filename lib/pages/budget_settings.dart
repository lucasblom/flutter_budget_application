import 'package:flutter/material.dart';
import 'package:flutter_budget_application/providers/budget_provider.dart';
import 'package:provider/provider.dart';

class BudgetSettings extends StatelessWidget {
  const BudgetSettings({super.key});

  
  @override
  Widget build(BuildContext context) {
    var budget = Provider.of<BudgetProvider>(context).budget;
    return Scaffold(

      appBar: AppBar(
        title: const Text("Budget Settings"),
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
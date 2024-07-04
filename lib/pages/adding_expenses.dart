import 'package:flutter/material.dart';
import 'package:flutter_budget_application/pages/budget_overview.dart';
import 'package:flutter_budget_application/pages/budget_settings.dart';
import 'package:flutter_budget_application/providers/budget_overview_provider.dart';
import 'package:provider/provider.dart';

class AddingExpenses extends StatelessWidget {
  const AddingExpenses({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Title(
            color: Colors.black,
            child: const Text("Add Expense", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          )
        ) 
      ),
      body: Column(
        children: [
          _ExpenseEdit(),
        ],
      ),
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
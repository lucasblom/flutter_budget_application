import 'package:flutter/material.dart';
import 'package:flutter_budget_application/pages/budget_overview.dart';
import 'package:flutter_budget_application/pages/budget_settings.dart';
import 'package:flutter_budget_application/providers/budget_overview_provider.dart';
import 'package:provider/provider.dart';

class AddingExpenses extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
              const Text('Add Expense', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
          _ExpenseEdit(),
        ],
      ),
    );
  }

}
/*
class AddingExpenses extends StatefulWidget {
  const AddingExpenses({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddingExpensesState createState() => _AddingExpensesState();
}


class _AddingExpensesState extends State<AddingExpenses> {
  @override
  Widget build(BuildContext context) {
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
                  // Navigate to the settings page
                },
                child: const Icon(Icons.settings),
              ),
              const Text('Add Expense', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              FloatingActionButton.small(
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ExpenseOverviewPage())); // Replace NewPage with your actual page class
                },
                child: const Icon(Icons.arrow_forward_ios_rounded),
              ),],
          ),)
         
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FractionallySizedBox(
            widthFactor: 0.5,
            child: Container(
              margin: const EdgeInsets.all(20),
                child: const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  labelText: 'Expense Amount',
                  labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ),

          const Text('Add New Expense:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Container(
            padding: const EdgeInsets.all(20),
            child: const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Expense Name',
              ),
            ),
          ),
          const Text('Category:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Container(
            padding: const EdgeInsets.all(10),
            child: const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Category Name',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                // Add the expense
              },
              child: const Text('Add Expense'),
            ),
          ),
        ],
      ),
    );
  }
}
*/
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
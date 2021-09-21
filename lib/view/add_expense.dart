import 'package:flutter/material.dart';

class AddExpense extends StatefulWidget {
  static const String id = "add_expanse";
  const AddExpense({Key? key}) : super(key: key);

  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Expense"),
      ),
      body: const SafeArea(
        child: Text("Text"),
      ),
    );
  }
}

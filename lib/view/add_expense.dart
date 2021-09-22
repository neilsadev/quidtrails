import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quidtrails/model/constants.dart';
import 'package:quidtrails/model/data.dart';
import 'package:quidtrails/model/user.dart';

class AddExpense extends StatefulWidget {
  static const String id = "add_expanse";
  const AddExpense({Key? key}) : super(key: key);

  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add New Expense"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: TextFormField(
                  maxLines: 1,
                  minLines: 1,
                  maxLength: 8,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: const Text(
                      "Amount",
                    ),
                    icon: Text(
                      Provider.of<User>(context).currency!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text("Expenses Made For"),
                  value: dropdownValue,
                  items: const <DropdownMenuItem<String>>[
                    DropdownMenuItem(
                      value: 'Option 1',
                      child: Text('Option 1'),
                    ),
                    DropdownMenuItem(
                      value: 'Option 2',
                      child: Text('Option 2'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      dropdownValue = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: TextFormField(
                  maxLines: 5,
                  minLines: 5,
                  maxLength: 160,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: "Description",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: MaterialButton(
                  minWidth: double.infinity,
                  color: K.purple,
                  onPressed: () {
                    print("Button Pressed");
                  },
                  child: const Text(
                    "Add",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

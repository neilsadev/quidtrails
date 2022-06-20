import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quidtrails/model/constants.dart';
import 'package:quidtrails/model/data.dart';
import 'package:quidtrails/model/user.dart';
import 'package:quidtrails/view/home_screen.dart';

class AddExpense extends StatefulWidget {
  static const String id = "add_expanse";
  const AddExpense({Key? key}) : super(key: key);

  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  String? amount;
  String? description;
  String? dropdownValue;
  List<String> expenseFor = K.expenseFor;

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
                  onChanged: (value) {
                    setState(() {
                      amount = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text("Expenses Made For"),
                  value: dropdownValue,
                  items: <DropdownMenuItem<String>>[
                    for (String val in expenseFor)
                      DropdownMenuItem(
                        value: val,
                        child: Text(val),
                      )
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
                  onChanged: (value) {
                    setState(() {
                      description = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: MaterialButton(
                  minWidth: double.infinity,
                  color: K.purple,
                  onPressed: () async {
                    await _insertIntoTable();
                    Navigator.popAndPushNamed(context, HomeScreen.id);
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

  _insertIntoTable() async {
    double? expAmount;
    try {
      expAmount = double.tryParse(amount!);
    } catch (e) {
      rethrow;
    }
    if (dropdownValue != null && description != null && expAmount != null) {
      Map<String, dynamic> row = {
        K.colNameExp["category"]!: dropdownValue,
        K.colNameExp["description"]!: description,
        K.colNameExp["amount"]!: double.tryParse(amount!),
        K.colNameExp["dateTime"]!: DateTime.now().toString()
      };
      try {
        await Provider.of<Data>(context, listen: false)
            .insertIntoExpenseTable(row);
      } catch (e) {
        rethrow;
      }
      await Provider.of<Data>(context, listen: false).fetchExpenseTableData();
    }
  }
}

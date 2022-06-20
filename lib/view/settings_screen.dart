import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quidtrails/controller/db.dart';
import 'package:quidtrails/model/constants.dart';
import 'package:quidtrails/model/formatter.dart';
import 'package:quidtrails/model/user.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = "settings_screen";
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final DBProvider _dbProvider = DBProvider.instance;
  String? name;
  String? budgetString;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TextFormField(
                      initialValue:
                          Provider.of<User>(context, listen: false).userName,
                      maxLines: 1,
                      minLines: 1,
                      maxLength: 50,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        label: const Text("Name"),
                        hintText:
                            Provider.of<User>(context, listen: false).userName,
                      ),
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TextFormField(
                      initialValue: Provider.of<User>(context, listen: false)
                          .thisMonthsBudget
                          ?.toString(),
                      minLines: 1,
                      maxLines: 1,
                      maxLength: 9,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: const Text("This months budget"),
                        hintText: Provider.of<User>(context, listen: false)
                            .thisMonthsBudget
                            ?.toString(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          budgetString = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: MaterialButton(
                      onPressed: () async {
                        bool nameChanged = false;
                        bool budgetUpdated = false;
                        if (name != null &&
                            name !=
                                Provider.of<User>(context, listen: false)
                                    .userName) {
                          await _dbProvider.update(
                              K.tableNameUser, {K.colNameUser["name"]!: name});
                          nameChanged = true;
                        }
                        if (budgetString != null &&
                            budgetString !=
                                Provider.of<User>(context, listen: false)
                                    .thisMonthsBudget
                                    ?.toString()) {
                          if (Provider.of<User>(context, listen: false)
                                  .thisMonthsBudget ==
                              null) {
                            await _dbProvider.insert(K.tableNameSummery, {
                              K.colNameSummery["month"]!:
                                  Formatter().formattedDate(DateTime.now()),
                              K.colNameSummery["budget"]!:
                                  int.parse(budgetString!),
                              K.colNameSummery["spent"]!: 0
                            });
                          } else {
                            await _dbProvider.update(
                                K.tableNameSummery,
                                {
                                  K.colNameSummery["budget"]!:
                                      int.parse(budgetString!)
                                },
                                where: "${K.colNameSummery["month"]!} = ?",
                                whereArgs: [
                                  Formatter().formattedDate(DateTime.now())
                                ]);
                          }
                          budgetUpdated = true;
                        }
                        if (nameChanged && budgetUpdated) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Name and Budget Updated")));
                        } else if (nameChanged) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Name Updated")));
                        } else if (budgetUpdated) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Budget Updated")));
                        }

                        Navigator.pop(context);
                      },
                      height: 50,
                      color: K.purple,
                      child: const Text(
                        "Save",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    "app made by appuccino",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

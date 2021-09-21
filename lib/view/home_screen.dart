import 'dart:typed_data';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quidtrails/controller/db.dart';
import 'package:quidtrails/model/constants.dart';
import 'package:quidtrails/model/data.dart';
import 'package:quidtrails/model/user.dart';
import 'package:quidtrails/model/formatter.dart';
import 'package:quidtrails/view/add_expense.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic _elements;

  @override
  void initState() {
    _fetchFromDB();
    super.initState();
  }

  _fetchFromDB() async {
    dynamic _e =
        await Provider.of<Data>(context, listen: false).expenseTableData;
    setState(() {
      _elements = _e;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Image.asset(
            "assets/images/app_logo.png",
          ),
        ),
        title: Text(
          Provider.of<User>(context).userName ?? "User",
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                EvaIcons.settings2Outline,
                color: K.black,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddExpense.id);
        },
        backgroundColor: K.purple,
        child: const Icon(EvaIcons.plus),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  color: K.black,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          "Budget left",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        // Text(Formatter().displayAmount(amount: Provider.of<Data>(context).budgetLeft!,currency: Provider.of<Data>(context).currency!, currencyMode: Provider.of<Data>(context).currencyMode!)),
                        Text(
                          Formatter()
                              .displayAmount(amount: 50000, currency: "\$"),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: _elements == null
                  ? const CircularProgressIndicator(
                      color: K.purple,
                    )
                  : StickyGroupedListView<dynamic, String>(
                      elements: _elements,
                      groupBy: (dynamic element) =>
                          element[K.colNameExp["dateTime"]],
                      groupSeparatorBuilder: (dynamic element) =>
                          Text(element[K.colNameExp["dateTime"]!]),
                      itemBuilder: (context, dynamic element) =>
                          Text(element[K.colNameExp["description"]!]),
                      itemComparator: (element1, element2) =>
                          element1[K.colNameExp["dateTime"]!].compareTo(
                              element2[K.colNameExp["dateTime"]!]), // optional
                      itemScrollController:
                          GroupedItemScrollController(), // optional
                      order: StickyGroupedListOrder.ASC, // optional
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quidtrails/model/constants.dart';
import 'package:quidtrails/model/data.dart';
import 'package:quidtrails/model/user.dart';
import 'package:quidtrails/model/formatter.dart';
import 'package:quidtrails/view/add_expense.dart';
import 'package:quidtrails/view/settings_screen.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>>? _elements;
  String dateToday = DateTime.now().toString().split(" ").first;
  String dateYesterday = DateTime.now()
      .subtract(const Duration(days: 1))
      .toString()
      .split(" ")
      .first;

  @override
  void initState() {
    _fetchFromDB();
    super.initState();
  }

  _fetchFromDB() async {
    List<Map<String, dynamic>>? _e =
        Provider.of<Data>(context, listen: false).expenseTableData;
    setState(() {
      _elements = _e;
    });
  }

  String _dateBanner(String date) {
    if (date == dateToday) {
      return "Today";
    } else if (date == dateYesterday) {
      return "Yesterday";
    }
    return date;
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
              onTap: () {
                Navigator.pushNamed(context, SettingsScreen.id);
              },
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
          if (Provider.of<User>(context, listen: false).thisMonthsBudget !=
              null) {
            Navigator.pushNamed(context, AddExpense.id);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Please set a budget from settings"),
              ),
            );
          }
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
                        Text(
                          Provider.of<User>(context, listen: false)
                                      .thisMonthsBudget !=
                                  null
                              ? Formatter().displayAmount(
                                  amount:
                                      Provider.of<User>(context, listen: false)
                                          .thisMonthsBudgetLeft!,
                                  currency:
                                      Provider.of<User>(context, listen: false)
                                          .currency!,
                                  currencyMode:
                                      Provider.of<User>(context, listen: false)
                                          .currencyMode!,
                                )
                              : "Set budget",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
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
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: K.purple,
                      ),
                    )
                  : _elements!.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 30.0, horizontal: 80.0),
                          child: Text(
                            "Please add a expense to keep track of your budget",
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: StickyGroupedListView<dynamic, String>(
                            stickyHeaderBackgroundColor: Colors.white,
                            elements: _elements!,
                            groupBy: (dynamic element) =>
                                element[K.colNameExp["dateTime"]]
                                    .toString()
                                    .split(" ")
                                    .first,
                            groupSeparatorBuilder: (dynamic element) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                _dateBanner(element[K.colNameExp["dateTime"]!]
                                    .toString()
                                    .split(" ")
                                    .first),
                              ),
                            ),
                            itemBuilder: (context, dynamic element) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: ListTile(
                                title: Text(element[K.colNameExp["category"]!]),
                                subtitle:
                                    Text(element[K.colNameExp["description"]!]),
                                trailing: Text(
                                  Formatter().displayAmount(
                                    amount: element[K.colNameExp["amount"]!],
                                    currency: Provider.of<User>(context,
                                            listen: false)
                                        .currency!,
                                    currencyMode: Provider.of<User>(context,
                                            listen: false)
                                        .currencyMode!,
                                  ),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                tileColor: Colors.grey.shade100,
                                dense: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            itemComparator: (element1, element2) =>
                                element1[K.colNameExp["dateTime"]!].compareTo(
                                    element2[
                                        K.colNameExp["dateTime"]!]), // optional
                            itemScrollController:
                                GroupedItemScrollController(), // optional
                            order: StickyGroupedListOrder.DESC, // optional
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

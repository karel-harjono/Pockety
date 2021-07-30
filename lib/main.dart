import 'package:flutter/material.dart';
import 'package:pockety/add_expense_button.dart';

import 'models.dart';
import 'styles.dart';

import 'package:provider/provider.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'fake_data.dart';

void main() => runApp(Pockety());

class Pockety extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: AppColors.accentColor),
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  static List<Expense> _expenses = [];
  // static List<Expense> _expenses = fakeData;

  HomePage({Key key, Expense expense}) {
    key = key;
    if (!_expenses.contains(expense) && expense != null) _expenses.add(expense);
    // print(_expenses);
  }

  @override
  _HomePageState createState() => _HomePageState(expenses: _expenses);
}

class _HomePageState extends State<HomePage> {
  List<Expense> _expenses = [];
  // final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  _HomePageState({@required List<Expense> expenses}) {
    _expenses = expenses;
    print(_expenses);
  }

  Widget _buildExpenseList() {
    return ListView.builder(
      itemCount: _expenses.length,
      itemBuilder: (context, index) {
        return _buildRow(index);
      },
    );
  }

  Widget _buildRow(int index) {
    final Expense e = _expenses[index];
    return ListTile(
      tileColor: e.isExpense ? Colors.redAccent : Colors.greenAccent,
      title: Text(e.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // _expenses.add(new _Expenses("type", "details", 0));
    return Scaffold(
      backgroundColor: AppColors.backgroundFadedColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(50))),
        title: Text(
          'My Monthly Expenses',
          style: TextStyle(color: Colors.white70, fontSize: 23),
        ),
        backgroundColor: AppColors.accentColor,
        shadowColor: Colors.indigo[300],
        elevation: 2,
        titleSpacing: 30,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.backgroundFadedColor,
                  AppColors.backgroundColor,
                ],
                stops: [0.0, 1],
              ),
            ),
          ),
          SafeArea(
            child: _buildExpenseList(),
          ),
          const Align(
            alignment: Alignment.bottomRight,
            child: AddExpenseButton(),
          )
        ],
      ),
    );
  }
}

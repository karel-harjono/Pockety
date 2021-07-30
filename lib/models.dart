import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

abstract class Category {
  final availableCategories = <String>['Food', 'Transport'];
}

/// represent expense or income items. Expense as default.
class Expense {
  Expense({
    @required this.category,
    @required this.details,
    @required this.amount,
    @required this.isExpense,
  });

  @override
  String toString() {
    return "category: $category, details: $details, amount: $amount, isExpense: $isExpense";
  }

  /// category of expense/income
  final String category;

  /// details
  final String details;

  /// how much
  final double amount;

  /// whether it is an expense or income
  final bool isExpense;
}

class ExpenseModel extends ChangeNotifier {
  final List<Expense> _expenses = [];

  /// An unmodifiable view of the expenses recorded.
  UnmodifiableListView<Expense> get expenses => UnmodifiableListView(_expenses);

  /// length of _expenses
  int get length => _expenses.length;

  void add(Expense e) {
    _expenses.add(e);

    /// notify Listener
    notifyListeners();
  }

  void removeAll() {
    _expenses.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}

import 'dart:convert';

import 'package:finance_app/data/model/expense_entry.dart';

class ExpensesList {
  List<ExpenseEntry> expenses;

  ExpensesList(this.expenses);

  Map<String, dynamic> toMap() {
    return {
      'expenses': expenses.map((x) => x.toMap()).toList(),
    };
  }

  factory ExpensesList.fromMap(Map<String, dynamic> map) {
    return ExpensesList(
      List<ExpenseEntry>.from(
        map['expenses']?.map((x) => ExpenseEntry.fromMap(x)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpensesList.fromJson(String source) =>
      ExpensesList.fromMap(json.decode(source));
}

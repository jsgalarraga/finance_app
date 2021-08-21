import 'dart:async';

import 'package:finance_app/data/model/expense_entry.dart';
import 'package:finance_app/data/model/expenses_list.dart';
import 'package:finance_app/data/model/savings_entry.dart';
import 'package:finance_app/data/model/savings_list.dart';
import 'package:http/http.dart' show Client;

class APIClient {
  final String url = 'http://10.0.2.2:3000';
  final String expensesPath = 'expenses';
  final String db = 'db';

  Future<bool> checkConnection({Client? client}) async {
    if (client == null) client = Client();
    try {
      final response = await client
          .get(Uri.parse('$url/$db'))
          .timeout(const Duration(seconds: 1));
      return response.statusCode == 200;
    } on TimeoutException {
      return false;
    }
  }

  Future<List<ExpenseEntry>> fetchExpenses({Client? client}) async {
    if (client == null) client = Client();
    final response = await client.get(Uri.parse('$url/$db'));

    if (response.statusCode == 200) {
      return ExpensesList.fromJson(response.body).expenses;
    } else {
      throw Exception(
        'Failed to load Expenses. Check the server is running',
      );
    }
  }

  Future<bool> addExpenseEntry(ExpenseEntry expense, {Client? client}) async {
    if (client == null) client = Client();
    final response = await client.post(
      Uri.parse('$url/$expensesPath'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: expense.toJson(),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception(
        'Failed to add expense. Check the server is running',
      );
    }
  }

  Future<bool> updateExpenseEntry(ExpenseEntry expense,
      {Client? client}) async {
    if (client == null) client = Client();
    final response = await client.put(
      Uri.parse('$url/$expensesPath/${expense.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: expense.toJson(),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(
        'Failed to update expense. Check the server is running',
      );
    }
  }

  Future<bool> deleteExpenseEntry(ExpenseEntry expense,
      {Client? client}) async {
    if (client == null) client = Client();
    final response = await client.delete(
      Uri.parse('$url/$expensesPath/${expense.id}'),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(
        'Failed to delete expense. Check the server is running',
      );
    }
  }

  Future<List<SavingsEntry>> fetchSavings({Client? client}) async {
    if (client == null) client = Client();
    final response = await client.get(Uri.parse('$url/$db'));

    if (response.statusCode == 200) {
      return SavingsList.fromJson(response.body).savings;
    } else {
      throw Exception(
        'Failed to load Savings. Check the server is running',
      );
    }
  }
}

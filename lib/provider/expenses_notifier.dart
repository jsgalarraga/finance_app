import 'package:finance_app/data/model/expense_entry.dart';
import 'package:finance_app/data/repositories/expenses_repository.dart';
import 'package:flutter/foundation.dart';

class ExpensesNotifier extends ChangeNotifier {
  final ExpensesRepository _expensesRepository;
  List<ExpenseEntry> expenses = [];

  ExpensesNotifier(this._expensesRepository);

  void fetchExpenses() async {
    expenses = await _expensesRepository.fetchExpenses();
    notifyListeners();
  }

  void addExpenseEntry(ExpenseEntry expense) async {
    await _expensesRepository.addExpenseEntry(expense);
    fetchExpenses();
  }

  void updateExpense(ExpenseEntry expense,
      {String? newTitle, num? newAmount}) async {
    if (newTitle != null) expense.title = newTitle;
    if (newAmount != null) expense.amount = newAmount;
    await _expensesRepository.updateExpenseEntry(expense);
    fetchExpenses();
  }

  void deleteExpenseEntry(ExpenseEntry expense) async {
    await _expensesRepository.deleteExpenseEntry(expense);
    fetchExpenses();
  }
}

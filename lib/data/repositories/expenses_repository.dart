import 'package:finance_app/data/api_client.dart';
import 'package:finance_app/data/model/expense_entry.dart';

class ExpensesRepository {
  final APIClient apiClient;

  ExpensesRepository(this.apiClient);

  Future<List<ExpenseEntry>> fetchExpenses() {
    return apiClient.fetchExpenses();
  }

  Future<bool> addExpenseEntry(ExpenseEntry expense) {
    return apiClient.addExpenseEntry(expense);
  }

  Future<bool> updateExpenseEntry(ExpenseEntry expense) {
    return apiClient.updateExpenseEntry(expense);
  }

  Future<bool> deleteExpenseEntry(ExpenseEntry expense) {
    return apiClient.deleteExpenseEntry(expense);
  }
}

import 'package:finance_app/data/api_client.dart';
import 'package:finance_app/data/repositories/expenses_repository.dart';
import 'package:finance_app/data/repositories/savings_repository.dart';
import 'package:finance_app/provider/expenses_notifier.dart';
import 'package:finance_app/provider/page_notifier.dart';
import 'package:finance_app/provider/savings_notifier.dart';
import 'package:finance_app/provider/server_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiClientProvider = Provider((ref) => APIClient());

final expensesRepositoryProvider = Provider(
  (ref) => ExpensesRepository(ref.read(apiClientProvider)),
);

final savingsRepositoryProvider = Provider(
  (ref) => SavingsRepository(ref.read(apiClientProvider)),
);

final expensesNotifierProvider = ChangeNotifierProvider<ExpensesNotifier>(
  (ref) => ExpensesNotifier(ref.read(expensesRepositoryProvider)),
);

final savingsNotifierProvider = ChangeNotifierProvider<SavingsNotifier>(
  (ref) => SavingsNotifier(ref.read(savingsRepositoryProvider)),
);

final pageNotifierProvider = ChangeNotifierProvider<PageNotifier>(
  (ref) => PageNotifier(),
);

final serverNotifierProvider = ChangeNotifierProvider<ServerNotifier>(
  (ref) => ServerNotifier(ref.read(apiClientProvider)),
);

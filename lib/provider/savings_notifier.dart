import 'package:finance_app/data/model/savings_entry.dart';
import 'package:finance_app/data/repositories/savings_repository.dart';
import 'package:flutter/foundation.dart';

class SavingsNotifier extends ChangeNotifier {
  final SavingsRepository _savingsRepository;
  List<SavingsEntry> savings = [];

  SavingsNotifier(this._savingsRepository);

  void fetchSavings() async {
    savings = await _savingsRepository.fetchSavings();
    notifyListeners();
  }

  Stream<List<SavingsEntry>> savingsStream() async* {
    while (true) {
      savings = await _savingsRepository.fetchSavings();
      yield savings;
      await Future.delayed(const Duration(seconds: 5), () {});
    }
  }
}

import 'package:finance_app/data/api_client.dart';
import 'package:finance_app/data/model/savings_entry.dart';

class SavingsRepository {
  final APIClient apiClient;

  SavingsRepository(this.apiClient);

  Future<List<SavingsEntry>> fetchSavings() {
    return apiClient.fetchSavings();
  }
}

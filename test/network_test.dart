import 'package:finance_app/data/api_client.dart';
import 'package:finance_app/data/model/expense_entry.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  test(
    "checkConnection. Returns true if the http call completes succesfully",
    () async {
      final String url = 'http://10.0.2.2:3000';
      final String db = 'db';
      final client = MockClient();
      when(
        client.get(Uri.parse('$url/$db')),
      ).thenAnswer(
        (_) async => http.Response('{"expenses": [], "savings": []}', 200),
      );
      final apiClient = APIClient();
      expect(await apiClient.checkConnection(client: client), true);
    },
  );

  test(
    "checkConnection. Returns false if the http call does not completes succesfully",
    () async {
      final String url = 'http://10.0.2.2:3000';
      final String db = 'db';
      final client = MockClient();
      when(
        client.get(Uri.parse('$url/$db')),
      ).thenAnswer(
        (_) async => http.Response('{"expenses": [], "savings": []}', 404),
      );
      final apiClient = APIClient();
      expect(await apiClient.checkConnection(client: client), false);
    },
  );

  test(
    "fetchExpenses. Returns a list of Expenses if the http call does succesfully",
    () async {
      final String url = 'http://10.0.2.2:3000';
      final String db = 'db';
      final client = MockClient();
      when(
        client.get(Uri.parse('$url/$db')),
      ).thenAnswer(
        (_) async => http.Response(
          '''
          {"expenses": [
            {"id": 0,"title": "initial balance", "amount": 120},
            {"id": 1,"title": "groceries", "amount": -24.3}
            ], 
            "savings": []
          }''',
          200,
        ),
      );
      final apiClient = APIClient();
      expect(
        await apiClient.fetchExpenses(client: client),
        isA<List<ExpenseEntry>>(),
      );
    },
  );
}

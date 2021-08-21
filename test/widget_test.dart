import 'package:finance_app/ui/pages/expenses_page.dart';
import 'package:finance_app/ui/pages/offline_page.dart';
import 'package:finance_app/ui/pages/savings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:finance_app/main.dart';

void main() {
  testWidgets('Inicialization test when server is offline',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(ProviderScope(child: MyApp()));

      // Verify that our app starts on the Offline page.
      expect(find.byType(OfflinePage), findsOneWidget);

      // Tap the savings page icon and trigger a frame.
      await tester.tap(find.byIcon(Icons.savings_outlined));
      await tester.pump();

      // Verify that our app is still in the Offline page.
      expect(find.byType(OfflinePage), findsOneWidget);
      expect(find.byType(ExpensesPage), findsNothing);
      expect(find.byType(SavingsPage), findsNothing);
    });
  });
}

import 'package:finance_app/ui/pages/expenses_page.dart';
import 'package:finance_app/ui/pages/savings_page.dart';
import 'package:finance_app/ui/widgets/info_widgets.dart';
import 'package:flutter/material.dart';

class PageNotifier extends ChangeNotifier {
  PageNotifier() : super();

  final List<Widget> pages = <Widget>[
    ExpensesPage(),
    SavingsPage(),
  ];
  final List<Function(BuildContext)> infoModeFn = <Function(BuildContext)>[
    showCustomSnackBar,
    showCustomBottomSheet,
  ];
  int currentPage = 0;

  void changePage(int index) {
    if ((index < 0) || (index >= pages.length)) {
      throw Exception('Page index out of range');
    }
    currentPage = index;
    notifyListeners();
  }

  void showInfo(BuildContext context) {
    infoModeFn[currentPage](context);
  }
}

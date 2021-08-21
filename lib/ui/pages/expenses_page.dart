import 'package:finance_app/data/model/accumulated_expense.dart';
import 'package:finance_app/data/model/expense_entry.dart';
import 'package:finance_app/provider/providers.dart';
import 'package:finance_app/ui/widgets/graph.dart';
import 'package:finance_app/utils/number_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finance_app/utils/string_utils.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({Key? key}) : super(key: key);

  /// Expenses page which contains a top graph and a bottom list with
  /// all expenses and current balance.

  @override
  _ExpensesPageState createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  @override
  void initState() {
    super.initState();
    context.read(expensesNotifierProvider).fetchExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, ScopedReader watch, Widget? child) {
        final expenses = watch(expensesNotifierProvider).expenses;

        return Column(
          children: [
            ExpensesGraph(expenses: expenses),
            ExpensesSeparator(expenses: expenses),
            ExpensesList(expenses: expenses),
          ],
        );
      },
    );
  }
}

class ExpensesGraph extends StatelessWidget {
  const ExpensesGraph({
    Key? key,
    required this.expenses,
  }) : super(key: key);

  final List<ExpenseEntry> expenses;

  @override
  Widget build(BuildContext context) {
    List<AccumulatedExpense> _data = [];

    if (expenses.isNotEmpty) {
      num sum = 0;
      _data = expenses.map((e) {
        sum += e.amount;
        return AccumulatedExpense(e.id!, sum);
      }).toList();
    }

    List<charts.Series<dynamic, num>> seriesList = [
      charts.Series<AccumulatedExpense, int>(
        id: 'Balance',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (AccumulatedExpense expense, _) => expense.id,
        measureFn: (AccumulatedExpense expense, _) => expense.value,
        data: _data,
      )
    ];
    return Expanded(child: SimpleLineChart(seriesList));
  }
}

class ExpensesSeparator extends StatelessWidget {
  const ExpensesSeparator({
    Key? key,
    required this.expenses,
  }) : super(key: key);

  final List<ExpenseEntry> expenses;

  @override
  Widget build(BuildContext context) {
    String totalBalance = '0';
    if (expenses.isNotEmpty) {
      totalBalance = expenses
          .map((element) => element.amount)
          .reduce((value, element) => value + element)
          .toStringAsFixed(2);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total balance: $totalBalance'),
          IconButton(
            onPressed: () {
              context.read(expensesNotifierProvider).addExpenseEntry(
                    ExpenseEntry(
                      title: 'New expense',
                      amount: NewRandom().number,
                    ),
                  );
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
    );
  }
}

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    Key? key,
    required this.expenses,
  }) : super(key: key);

  final List<ExpenseEntry> expenses;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (BuildContext context, int index) {
          return ExpenseTile(expense: expenses[index]);
        },
      ),
    );
  }
}

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({Key? key, required this.expense}) : super(key: key);

  final ExpenseEntry expense;

  @override
  Widget build(BuildContext context) {
    final bool positiveAmount = expense.amount > 0;
    final leadingIcon = positiveAmount ? Icons.add : Icons.remove;
    final leadingColor = positiveAmount ? Colors.green : Colors.red;
    return ListTile(
      title: Text(expense.title.capitalize()),
      subtitle: Text('${expense.amount}'),
      leading: CircleAvatar(
        child: Icon(leadingIcon),
        backgroundColor: leadingColor,
        foregroundColor: Colors.white,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              context.read(expensesNotifierProvider).updateExpense(
                    expense,
                    newAmount: 15.2,
                    newTitle: 'updated title',
                  );
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              context.read(expensesNotifierProvider).deleteExpenseEntry(
                    expense,
                  );
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}

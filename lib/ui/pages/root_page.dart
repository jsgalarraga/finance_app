import 'package:finance_app/provider/providers.dart';
import 'package:finance_app/ui/pages/offline_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RootPage extends ConsumerWidget {
  RootPage({Key? key}) : super(key: key);

  /// This is the root widget of the app, which provides a Scaffold that
  /// contains a bottomNavigationBar for navigation between screens.
  /// Handles the error page when there is no connection with the server.

  final String title = 'Demo Finance App';

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final List pagesList = context.read(pageNotifierProvider).pages;
    final int currentPage = watch(pageNotifierProvider).currentPage;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () {
              context.read(serverNotifierProvider).refreshServerConnection();
              context.read(pageNotifierProvider).showInfo(context);
            },
            icon: Icon(Icons.info_outline),
          )
        ],
      ),
      body: StreamBuilder<bool>(
        stream: context.read(serverNotifierProvider).connectionStream(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data == true) return pagesList[currentPage];
          return OfflinePage();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: context.read(pageNotifierProvider).changePage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on_outlined),
            label: 'Expenses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.savings_outlined),
            label: 'Savings',
          ),
        ],
      ),
    );
  }
}

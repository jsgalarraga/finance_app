import 'package:finance_app/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void showCustomSnackBar(BuildContext context) {
  final snackBar = SnackBar(
    content: Consumer(
      builder: (BuildContext context, ScopedReader watch, Widget? child) {
        final serverConnection = watch(serverNotifierProvider).connected;
        final serverConnectionStr =
            serverConnection ? 'Connected' : 'Disconnected';
        return Text(serverConnectionStr);
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showCustomBottomSheet(BuildContext context) {
  final borderRadius = BorderRadius.vertical(top: Radius.circular(10));
  showBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: borderRadius,
    ),
    context: context,
    builder: (context) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          width: double.infinity,
          height: 58,
          alignment: Alignment.center,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green,
          ),
          child: Consumer(
            builder: (BuildContext context, ScopedReader watch, Widget? child) {
              final serverConnection = watch(serverNotifierProvider).connected;
              final serverConnectionStr =
                  serverConnection ? 'Connected' : 'Disconnected';
              return Text(
                'Server $serverConnectionStr',
                style: TextStyle(color: Colors.white, fontSize: 20),
              );
            },
          ),
        ),
      );
    },
  );
}

import 'package:flutter/material.dart';

class OfflinePage extends StatelessWidget {
  const OfflinePage({Key? key}) : super(key: key);

  /// Shows a simple text when there is no connection with the server.

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Couldn't connect with server"),
    );
  }
}

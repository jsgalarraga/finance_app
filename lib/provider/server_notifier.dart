import 'package:finance_app/data/api_client.dart';
import 'package:flutter/material.dart';

class ServerNotifier extends ChangeNotifier {
  final APIClient _apiClient;
  bool connected = false;

  ServerNotifier(this._apiClient);

  void refreshServerConnection() async {
    connected = await _apiClient.checkConnection();
    notifyListeners();
  }

  Stream<bool> connectionStream() async* {
    while (true) {
      connected = await _apiClient.checkConnection();
      yield connected;
      await Future.delayed(const Duration(seconds: 5));
    }
  }
}

import 'dart:convert';

import 'package:finance_app/data/model/savings_entry.dart';

class SavingsList {
  List<SavingsEntry> savings;

  SavingsList(this.savings);

  Map<String, dynamic> toMap() {
    return {
      'savings': savings.map((x) => x.toMap()).toList(),
    };
  }

  factory SavingsList.fromMap(Map<String, dynamic> map) {
    return SavingsList(
      List<SavingsEntry>.from(
        map['savings']?.map((x) => SavingsEntry.fromMap(x)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SavingsList.fromJson(String source) =>
      SavingsList.fromMap(json.decode(source));
}

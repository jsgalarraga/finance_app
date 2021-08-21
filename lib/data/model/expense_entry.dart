import 'dart:convert';

class ExpenseEntry {
  String title;
  num amount;
  final int? id;

  ExpenseEntry({
    required this.title,
    required this.amount,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'amount': amount,
    };
  }

  factory ExpenseEntry.fromMap(Map<String, dynamic> map) {
    return ExpenseEntry(
      title: map['title'],
      amount: map['amount'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpenseEntry.fromJson(String source) =>
      ExpenseEntry.fromMap(json.decode(source));
}

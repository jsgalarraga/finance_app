import 'dart:convert';

class SavingsEntry {
  final int _id;
  int _value;

  SavingsEntry(this._id, this._value);

  int get id => _id;
  int get value => _value;

  set updateValue(int newValue) {
    _value = newValue;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'value': value,
    };
  }

  factory SavingsEntry.fromMap(Map<String, dynamic> map) {
    return SavingsEntry(
      map['id'],
      map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SavingsEntry.fromJson(String source) =>
      SavingsEntry.fromMap(json.decode(source));
}

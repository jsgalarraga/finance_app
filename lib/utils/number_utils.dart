import 'dart:math';

class NewRandom {
  final _random = Random();

  late final int number = -50 + _random.nextInt(100);
}

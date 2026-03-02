import 'package:equatable/equatable.dart';

class RandomNumber extends Equatable {
  final int value;

  const RandomNumber({required this.value});

  @override
  List<Object?> get props => [value];
}

import 'package:myapp/domain/entities/random_number.dart';

abstract class RandomNumberRepository {
  Future<RandomNumber> getRandomNumber();
}

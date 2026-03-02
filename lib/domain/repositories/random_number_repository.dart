import 'package:dartz/dartz.dart';
import 'package:myapp/core/errors/failures.dart';
import 'package:myapp/domain/entities/random_number.dart';

abstract class RandomNumberRepository {
  Future<Either<Failure, RandomNumber>> getRandomNumber();
}

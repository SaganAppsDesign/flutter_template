import 'package:dartz/dartz.dart';
import 'package:myapp/core/errors/failures.dart';
import 'package:myapp/core/usecases/usecase.dart';
import 'package:myapp/domain/entities/random_number.dart';
import 'package:myapp/domain/repositories/random_number_repository.dart';

class GetRandomNumberUseCase extends UseCase<RandomNumber, NoParams> {
  final RandomNumberRepository repository;

  GetRandomNumberUseCase(this.repository);

  @override
  Future<Either<Failure, RandomNumber>> call(NoParams params) {
    return repository.getRandomNumber();
  }
}

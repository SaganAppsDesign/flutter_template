import 'package:myapp/domain/entities/random_number.dart';
import 'package:myapp/domain/repositories/random_number_repository.dart';

class GetRandomNumberUseCase {
  final RandomNumberRepository repository;

  GetRandomNumberUseCase(this.repository);

  Future<RandomNumber> call() {
    return repository.getRandomNumber();
  }
}

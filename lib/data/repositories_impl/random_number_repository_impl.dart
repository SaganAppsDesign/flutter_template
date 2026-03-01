import 'package:myapp/data/datasources/random_number_remote_data_source.dart';
import 'package:myapp/domain/entities/random_number.dart';
import 'package:myapp/domain/repositories/random_number_repository.dart';

class RandomNumberRepositoryImpl implements RandomNumberRepository {
  final RandomNumberRemoteDataSource remoteDataSource;

  RandomNumberRepositoryImpl({required this.remoteDataSource});

  @override
  Future<RandomNumber> getRandomNumber() {
    return remoteDataSource.getRandomNumber();
  }
}

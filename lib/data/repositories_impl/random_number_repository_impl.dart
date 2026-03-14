import 'package:dartz/dartz.dart';
import 'package:myapp/core/errors/failures.dart';
import 'package:myapp/data/datasources/random_number_remote_data_source.dart';
import 'package:myapp/domain/entities/random_number.dart';
import 'package:myapp/domain/repositories/random_number_repository.dart';

class RandomNumberRepositoryImpl implements RandomNumberRepository {
  RandomNumberRepositoryImpl({required this.remoteDataSource});
  final RandomNumberRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, RandomNumber>> getRandomNumber() async {
    try {
      final result = await remoteDataSource.getRandomNumber();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

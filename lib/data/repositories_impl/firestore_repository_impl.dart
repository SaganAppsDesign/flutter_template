import 'package:dartz/dartz.dart';
import 'package:myapp/core/errors/failures.dart';
import 'package:myapp/data/datasources/firestore_remote_data_source.dart';
import 'package:myapp/domain/repositories/firestore_repository.dart';

class FirestoreRepositoryImpl implements FirestoreRepository {
  FirestoreRepositoryImpl(this.remoteDataSource);
  final FirestoreRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, void>> saveData(
    String collection,
    Map<String, dynamic> data,
  ) async {
    try {
      await remoteDataSource.addDocument(collection, data);
      return const Right(null);
    } catch (e) {
      return Left(FirestoreFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>?>> getData(
    String collection,
    String id,
  ) async {
    try {
      final doc = await remoteDataSource.getDocument(collection, id);
      return Right(doc.data());
    } catch (e) {
      return Left(FirestoreFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<Map<String, dynamic>>>> watchCollection(
    String collection,
  ) {
    return remoteDataSource
        .getCollectionStream(collection)
        .map<Either<Failure, List<Map<String, dynamic>>>>(
          (snapshot) => Right(snapshot.docs.map((doc) => doc.data()).toList()),
        )
        .handleError((e) {
          return Left<Failure, List<Map<String, dynamic>>>(
            FirestoreFailure(e.toString()),
          );
        });
  }
}

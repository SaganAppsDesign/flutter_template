import 'package:dartz/dartz.dart';
import 'package:myapp/core/errors/failures.dart';

abstract class FirestoreRepository {
  Future<Either<Failure, void>> saveData(
    String collection,
    Map<String, dynamic> data,
  );
  Future<Either<Failure, Map<String, dynamic>?>> getData(
    String collection,
    String id,
  );
  Stream<Either<Failure, List<Map<String, dynamic>>>> watchCollection(
    String collection,
  );
}

import 'package:dartz/dartz.dart';
import 'package:myapp/core/errors/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> signIn(String email, String password);
  Future<Either<Failure, void>> signUp(String email, String password);
  Future<void> signOut();
  Stream<bool> get authStateChanges;
}

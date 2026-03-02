import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:myapp/core/errors/failures.dart';
import 'package:myapp/domain/repositories/auth_repository.dart';

class FirebaseAuthService implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthService(this._firebaseAuth);

  @override
  Future<Either<Failure, void>> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return const Right(null);
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return const Right(null);
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Stream<bool> get authStateChanges =>
      _firebaseAuth.authStateChanges().map((user) => user != null);
}

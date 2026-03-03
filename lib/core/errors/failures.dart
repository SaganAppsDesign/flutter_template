abstract class Failure {
  const Failure([this.message = '']);
  final String message;
}

class ServerFailure extends Failure {
  const ServerFailure([super.message]);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message]);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message]);
}

class FirebaseFailure extends Failure {
  const FirebaseFailure([super.message]);
}

class FirestoreFailure extends FirebaseFailure {
  const FirestoreFailure([super.message]);
}

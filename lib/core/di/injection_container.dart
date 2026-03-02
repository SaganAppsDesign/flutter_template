import 'package:get_it/get_it.dart';
import 'package:myapp/domain/repositories/random_number_repository.dart';
import 'package:myapp/data/repositories_impl/random_number_repository_impl.dart';
import 'package:myapp/data/datasources/random_number_remote_data_source.dart';
import 'package:myapp/domain/usecases/get_random_number_usecase.dart';
import 'package:myapp/presentation/viewmodel/random_number_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:myapp/core/services/secure_storage_service.dart';
import 'package:myapp/core/network/dio_client.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/domain/repositories/auth_repository.dart';
import 'package:myapp/data/datasources/firebase_auth_service.dart';
import 'package:myapp/core/config/app_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/data/datasources/firestore_remote_data_source.dart';
import 'package:myapp/domain/repositories/firestore_repository.dart';
import 'package:myapp/data/repositories_impl/firestore_repository_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Random Number

  // ViewModels
  sl.registerFactory(() => RandomNumberViewModel(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetRandomNumberUseCase(sl()));

  // Data sources
  sl.registerLazySingleton<RandomNumberRemoteDataSource>(
    () => RandomNumberRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<FirestoreRemoteDataSource>(
    () => FirestoreRemoteDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<RandomNumberRepository>(
    () => RandomNumberRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<FirestoreRepository>(
    () => FirestoreRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<AuthRepository>(() => FirebaseAuthService(sl()));

  // Core
  sl.registerLazySingleton<SecurityService>(
    () => SecureStorageService(const FlutterSecureStorage()),
  );
  sl.registerLazySingleton(() => DioClient(sl()));

  // External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseAuth.instance);

  // App Config (can be initialized based on environment)
  sl.registerLazySingleton(() => AppConfig.dev());
}

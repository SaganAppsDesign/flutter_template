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

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Random Number

  // ViewModels
  sl.registerFactory(() => RandomNumberViewModel(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetRandomNumberUseCase(sl()));

  // Repository
  sl.registerLazySingleton<RandomNumberRepository>(
    () => RandomNumberRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<RandomNumberRemoteDataSource>(
    () => RandomNumberRemoteDataSourceImpl(),
  );

  // Core
  sl.registerLazySingleton<SecurityService>(
    () => SecureStorageService(const FlutterSecureStorage()),
  );
  sl.registerLazySingleton(() => DioClient(sl()));

  // External
  sl.registerLazySingleton(() => Dio());
}

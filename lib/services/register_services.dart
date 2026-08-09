import 'package:dio/dio.dart';
import 'package:faker/faker.dart';
import 'package:get_it/get_it.dart';
import 'package:shom_gn/config/env.dart';
import 'package:shom_gn/services/address_service.dart';
import 'package:shom_gn/services/api_service.dart';
import 'package:shom_gn/services/image_service.dart';
import 'package:shom_gn/services/localisation_service.dart';
import 'package:shom_gn/services/seed_service.dart';
import 'package:shom_gn/services/user_service.dart';

final getIt = GetIt.instance;

void initServices(Env env) {
  final api = ApiService(
    env: env,
    currency: 'GNF',
    dio: Dio(BaseOptions(baseUrl: env.baseUrl)),
  );
  getIt.registerLazySingleton<UserService>(() => UserService(api: api));
  getIt.registerLazySingleton<ImageService>(() => ImageService());
  getIt.registerLazySingleton<SeedService>(
    () => SeedService(api: api, faker: Faker()),
  );
  getIt.registerLazySingleton<LocalisationService>(
    () => LocalisationService(api: api),
  );
  getIt.registerLazySingleton<AddressService>(() => AddressService(api: api));

  //

  //
}

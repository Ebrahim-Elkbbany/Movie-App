import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/api_service.dart';
import '../utils/change_lang/localization_cubit.dart';
import '../utils/shared_prefrences_helper.dart';
import '../../../features/login/data/data_sources/login_remote_data_source.dart';
import '../../../features/login/data/repos/login_repo_impl.dart';
import '../../../features/login/domain/repos/login_repo.dart';
import '../../../features/login/domain/use_case/login_use_case.dart';
import '../../../features/login/presentation/manager/login_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  
  getIt.registerLazySingleton<SharedPrefsHelper>(
    () => SharedPrefsHelper(sharedPreferences: sharedPreferences),
  );


  getIt.registerSingletonAsync<ApiService>(() async => await ApiService.create());
  await getIt.isReady<ApiService>();

  getIt.registerLazySingleton<Dio>(() => getIt<ApiService>().dio);

  getIt.registerLazySingleton<LocalizationCubit>(
    () => LocalizationCubit(getIt<SharedPrefsHelper>()),
  );

  // Login Feature
  getIt.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(apiService: getIt<ApiService>()),
  );

  getIt.registerLazySingleton<LoginRepo>(
    () => LoginRepoImpl(loginRemoteDataSource: getIt<LoginRemoteDataSource>()),
  );

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(loginRepo: getIt<LoginRepo>()),
  );

  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<LoginUseCase>()));


  await getIt.allReady();
}

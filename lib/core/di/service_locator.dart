import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/features/home/data/data_sources/movies_details_data_source.dart';
import 'package:movie_app/features/home/data/data_sources/movies_details_data_source_impl.dart';
import 'package:movie_app/features/home/data/data_sources/movies_remote_data_source.dart';
import 'package:movie_app/features/home/data/data_sources/movies_remote_data_source_impl.dart';
import 'package:movie_app/features/home/data/repos/movies_details_repo.dart';
import 'package:movie_app/features/home/data/repos/movies_details_repo_impl.dart';
import 'package:movie_app/features/home/data/repos/movies_repo.dart';
import 'package:movie_app/features/home/data/repos/movies_repo_impl.dart';
import 'package:movie_app/features/home/presentation/manager/movies_cubit.dart';
import 'package:movie_app/features/home/presentation/manager/movies_details_cubit.dart';
import 'package:movie_app/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movie_app/core/network/api_service.dart';
import 'package:movie_app/core/utils/shared_prefrences_helper.dart';
import 'package:movie_app/features/auth/data/repos/auth_repo.dart';
import 'package:movie_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:movie_app/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:movie_app/features/auth/presentation/manager/signup_cubit/signup_cubit.dart';
import 'package:movie_app/features/profile/data/repos/profile_repo.dart';
import 'package:movie_app/features/profile/data/repos/profile_repo_impl.dart';
import 'package:movie_app/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  await Firebase.initializeApp();

  final sharedPreferences = await SharedPreferences.getInstance();

  getIt.registerLazySingleton<SharedPrefsHelper>(
    () => SharedPrefsHelper(sharedPreferences: sharedPreferences),
  );

  getIt.registerLazySingleton<OnBoardingCubit>(() => OnBoardingCubit());
  getIt.registerSingletonAsync<ApiService>(
    () async => await ApiService.create(),
  );
  await getIt.isReady<ApiService>();

  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(getIt<FirebaseAuth>(), getIt<FirebaseFirestore>()),
  );

  getIt.registerLazySingleton<MoviesRemoteDataSource>(
    () => MoviesRemoteDataSourceImpl(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<MoviesDetailsDataSource>(
    () => MoviesDetailsDataSourceImpl(apiService: getIt<ApiService>()),
  );
  getIt.registerLazySingleton<MoviesDetailsRepository>(
    () => MoviesDetailsRepositoryImpl(
      dataSource: getIt<MoviesDetailsDataSource>(),
    ),
  );
  getIt.registerLazySingleton<MoviesRepository>(
    () => MoviesRepositoryImpl(getIt<MoviesRemoteDataSource>()),
  );
  getIt.registerFactory(() => MoviesCubit(getIt<MoviesRepository>()));
  getIt.registerFactory(() => MoviesDetailsCubit(getIt<MoviesDetailsRepository>()));
  getIt.registerLazySingleton<ProfileRepo>(
    () => ProfileRepoImpl(
      firebaseAuth: getIt<FirebaseAuth>(),
      firestore: getIt<FirebaseFirestore>(),
    ),
  );

  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<AuthRepo>()));
  getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt<AuthRepo>()));
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt<ProfileRepo>()));

  await getIt.allReady();
}

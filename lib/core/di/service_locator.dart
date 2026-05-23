import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
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

getIt.registerLazySingleton<OnBoardingCubit>(
  () => OnBoardingCubit(),
);
  getIt.registerSingletonAsync<ApiService>(() async => await ApiService.create());
  await getIt.isReady<ApiService>();

  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      getIt<FirebaseAuth>(),
      getIt<FirebaseFirestore>(),
    ),
  );

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

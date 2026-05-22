import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/profile/data/repos/profile_repo.dart';
import 'package:movie_app/features/profile/presentation/manager/profile_cubit/profile_state.dart';
import 'package:movie_app/features/auth/data/models/user_model.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _profileRepo;

  ProfileCubit(this._profileRepo) : super(ProfileInitial());

  UserModel? currentUser;

  Future<void> fetchUserData() async {
    emit(ProfileLoading());
    final result = await _profileRepo.getUserData();
    result.fold(
      (failure) => emit(ProfileError(failure.errorMessage)),
      (user) {
        currentUser = user;
        emit(ProfileLoaded(user));
      },
    );
  }

  Future<void> logout() async {
    emit(ProfileActionLoading());
    final result = await _profileRepo.logout();
    result.fold(
      (failure) => emit(ProfileActionError(failure.errorMessage)),
      (_) => emit(ProfileLogoutSuccess()),
    );
  }

  Future<void> deleteAccount() async {
    emit(ProfileActionLoading());
    final result = await _profileRepo.deleteAccount();
    result.fold(
      (failure) => emit(ProfileActionError(failure.errorMessage)),
      (_) => emit(ProfileDeleteSuccess()),
    );
  }

  Stream<List<Map<String, dynamic>>> get watchlistStream => _profileRepo.getWatchlist();
  Stream<List<Map<String, dynamic>>> get historyStream => _profileRepo.getHistory();
}

import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/utils/constants/storage_keys.dart';
import 'package:movie_app/core/utils/shared_prefrences_helper.dart';
part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  final SharedPrefsHelper _sharedPrefsHelper;
  LocalizationCubit(this._sharedPrefsHelper) : super(LocalizationInitial());

  String get currentLangCode => _sharedPrefsHelper.getString(StorageKeys.locale) ?? 'ar';

  String get appLanguageName => 
      currentLangCode == 'ar' ? '(AR) العربية' : '(EN) English';

  Future<void> changeLanguage(String langCode) async {
    try {
      emit(LocalizationLoading());
      await _sharedPrefsHelper.setString(StorageKeys.locale, langCode);
      emit(LocalizationSuccess(Locale(langCode)));
    } catch (e) {
      emit(LocalizationFailure(e.toString()));
    }
  }

  Locale getLocale() {
    return Locale(currentLangCode);
  }

  bool isArabic() {
    return currentLangCode == 'ar';
  }
}

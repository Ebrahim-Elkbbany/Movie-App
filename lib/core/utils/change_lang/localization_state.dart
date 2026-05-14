part of 'localization_cubit.dart';

abstract class LocalizationState {}

final class LocalizationInitial extends LocalizationState {}

final class LocalizationLoading extends LocalizationState {}

final class LocalizationSuccess extends LocalizationState {
  final Locale locale;
  LocalizationSuccess(this.locale);
}

final class LocalizationFailure extends LocalizationState {
  final String errorMessage;
  LocalizationFailure(this.errorMessage);
}

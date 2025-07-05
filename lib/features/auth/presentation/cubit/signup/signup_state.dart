import 'package:fruits_hub/features/auth/domain/entity/user_entity.dart';

abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final UserEntity user;

  SignupSuccess({required this.user});
}

class SignupFailure extends SignupState {
  final String error;

  SignupFailure(this.error);
}

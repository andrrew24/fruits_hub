import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/features/auth/domain/repo/auth_repo.dart';
import 'package:fruits_hub/features/auth/presentation/cubit/signup/signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(SignupInitial());

  final AuthRepo authRepo;

  Future<void> signupUser({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(SignupLoading());

    final result = await authRepo.createUserwithEmailandPassword(
      name: name,
      email: email,
      password: password,
    );

    result.fold(
      (failure) {
        emit(SignupFailure(failure.message));
      },
      (user) {
        emit(SignupSuccess(user: user));
      },
    );
  }
}

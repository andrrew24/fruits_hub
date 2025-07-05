import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/features/auth/domain/entity/user_entity.dart';
import 'package:fruits_hub/features/auth/domain/repo/auth_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitial());

  final AuthRepo authRepo;

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());

    final result = await authRepo.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    result.fold(
      (failure) {
        emit(LoginFailure(failure.message));
      },
      (user) {
        emit(LoginSuccess(user: user));
      },
    );
  }

  Future<void> loginWithGoogle() async {
    emit(LoginLoading());

    final result = await authRepo.signInWithGoogle();

    result.fold(
      (failure) {
        emit(LoginFailure(failure.message));
      },
      (user) {
        emit(LoginSuccess(user: user));
      },
    );
  }

  Future<void> loginWithFacebook() async {
    emit(LoginLoading());

    final result = await authRepo.signInWithFacebook();

    result.fold(
      (failure) {
        emit(LoginFailure(failure.message));
      },
      (user) {
        emit(LoginSuccess(user: user));
      },
    );
  }
}

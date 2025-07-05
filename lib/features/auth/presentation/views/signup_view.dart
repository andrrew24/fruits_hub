import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/services/service_locator.dart';
import 'package:fruits_hub/core/widgets/custom_app_bar.dart';
import 'package:fruits_hub/features/auth/domain/repo/auth_repo.dart';
import 'package:fruits_hub/features/auth/presentation/cubit/signup/signup_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/cubit/signup/signup_state.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'widgets/signup_view_body.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  static const routeName = 'signup';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: "حساب جديد"),
      body: BlocProvider(
        create: (context) => SignupCubit(serviceLocator<AuthRepo>()),
        child: BlocConsumer<SignupCubit, SignupState>(
          listener: (BuildContext context, SignupState state) {
            if (state is SignupSuccess) {
              Navigator.pop(context);
            } else if (state is SignupFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (BuildContext context, SignupState state) {
            return ModalProgressHUD(
              inAsyncCall: state is SignupLoading,
              child: SignupViewBody(),
            );
          },
        ),
      ),
    );
  }
}

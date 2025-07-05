import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/constants.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_images.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
import 'package:fruits_hub/core/widgets/custom_button.dart';
import 'package:fruits_hub/core/widgets/custom_text_field.dart';
import 'package:fruits_hub/core/widgets/password_field.dart';
import 'package:fruits_hub/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/views/widgets/or_divider.dart';
import 'package:fruits_hub/features/auth/presentation/views/widgets/social_login_button.dart';

import 'dont_have_account_widget.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  String? _email, _password;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizintalPadding),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidateMode,
            child: Column(
              children: [
                const SizedBox(height: 24),
                CustomTextFormField(
                  hintText: 'البريد الالكتروني',
                  textInputType: TextInputType.emailAddress,
                  onSaved: (p0) {
                    _email = p0;
                  },
                  isObscured: false,
                ),
                const SizedBox(height: 16),
                PasswordField(
                  suffixIcon: Icon(
                    Icons.remove_red_eye,
                    color: Color(0xffC9CECF),
                  ),
                  hintText: 'كلمة المرور',
                  textInputType: TextInputType.visiblePassword,
                  onSaved: (p0) {
                    _password = p0;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'نسيت كلمة المرور؟',
                      style: TextStyles.semiBold13.copyWith(
                        color: AppColors.lightPrimaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 33),
                CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      context.read<LoginCubit>().loginUser(
                        email: _email!,
                        password: _password!,
                      );
                    } else {
                      setState(() {
                        _autovalidateMode = AutovalidateMode.always;
                      });
                    }
                  },
                  text: 'تسجيل دخول',
                ),
                const SizedBox(height: 33),
                const DontHaveAnAccountWidget(),
                const SizedBox(height: 33),
                const OrDivider(),
                const SizedBox(height: 16),
                SocialLoginButton(
                  onPressed: () {
                    context.read<LoginCubit>().loginWithGoogle();
                  },
                  image: Assets.imagesGoogleIcon,
                  title: 'تسجيل بواسطة جوجل',
                ),
                const SizedBox(height: 16),
                SocialLoginButton(
                  onPressed: () {},
                  image: Assets.imagesApplIcon,
                  title: 'تسجيل بواسطة أبل',
                ),
                const SizedBox(height: 16),
                SocialLoginButton(
                  onPressed: () {
                    context.read<LoginCubit>().loginWithFacebook();
                  },
                  image: Assets.imagesFacebookIcon,
                  title: 'تسجيل بواسطة فيسبوك',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

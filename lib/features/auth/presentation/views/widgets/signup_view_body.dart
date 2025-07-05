import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/constants.dart';
import 'package:fruits_hub/core/widgets/custom_button.dart';
import 'package:fruits_hub/core/widgets/custom_text_field.dart';
import 'package:fruits_hub/core/widgets/password_field.dart';
import 'package:fruits_hub/features/auth/presentation/cubit/signup/signup_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/views/widgets/have_an_account_widget.dart';
import 'package:fruits_hub/features/auth/presentation/views/widgets/terms_and_conditions.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  String? _email, _password, _name;
  bool _isTermsAccepted = false;

  @override
  void dispose() {
    super.dispose();
    _formKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizintalPadding),
        child: Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: Column(
            children: [
              const SizedBox(height: 24),
              CustomTextFormField(
                hintText: 'الاسم كامل',
                textInputType: TextInputType.name,
                onSaved: (p0) {
                  _name = p0;
                },
                isObscured: false,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                hintText: 'البريد الإلكتروني',
                textInputType: TextInputType.emailAddress,
                onSaved: (p0) {
                  _email = p0;
                },
                isObscured: false,
              ),
              const SizedBox(height: 16),
              PasswordField(
                onSaved: (p0) {
                  _password = p0;
                },
                suffixIcon: Icon(
                  Icons.remove_red_eye,
                  color: Color(0xffC9CECF),
                ),
                hintText: 'كلمة المرور',
                textInputType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 16),
              TermsAndConditionsWidget(
                onChecked: (value) {
                  _isTermsAccepted = value;
                },
              ),
              const SizedBox(height: 30),
              CustomButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (_isTermsAccepted) {
                      _formKey.currentState!.save();
                      context.read<SignupCubit>().signupUser(
                        email: _email!,
                        password: _password!,
                        name: _name!,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('يجب قبول الشروط والأحكام')),
                      );
                    }
                  } else {
                    setState(() {
                      _autovalidateMode = AutovalidateMode.always;
                    });
                  }
                },
                text: 'إنشاء حساب جديد',
              ),
              const SizedBox(height: 26),
              const HaveAnAccountWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

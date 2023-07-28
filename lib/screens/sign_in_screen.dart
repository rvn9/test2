import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../auth_guard.dart';
import '../bloc/authentication/authentication_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../routes/router.gr.dart';
import '../widgets/custom_button_widgets.dart';
import '../widgets/custom_text_form_field.dart';

class SignInScreen extends StatefulWidget {
  static const route = AdaptiveRoute(
    page: SignInScreen,
    initial: true,
    path: 'sign_in',
    guards: [AuthGuard],
  );

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final AuthenticationCubit _authenticationCubit;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _authenticationCubit = AuthenticationCubit.create();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _authenticationCubit.close();
    _emailController.clear();
    _passwordController.clear();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: _authenticationCubit,
        child: BlocListener<AuthenticationCubit, AuthenticationState>(
          listener: (context, state) => state.maybeWhen(
            orElse: () => null,
            signIn: () =>
                AutoRouter.of(context).replace(const HomeScreenRoute()),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: key,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                'Email',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            CustomTextFormField(
                              controller: _emailController,
                              textInputAction: TextInputAction.next,
                              maxLines: 1,
                              hintText: 'Your username',
                              hasClearButton: true,
                              validator: (value) {
                                if (value == '') {
                                  return 'Enter an username';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  'Password',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              CustomTextFormField(
                                controller: _passwordController,
                                textInputAction: TextInputAction.done,
                                maxLines: 1,
                                hintText: 'Your password',
                                hasObscureToggle: true,
                                obscureText: true,
                                validator: (value) {
                                  if (value == '') {
                                    return 'Enter a password';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => AutoRouter.of(context).push(
                      SignUpScreenRoute(
                        onSignUp: (email, password, name) =>
                            _authenticationCubit.signUp(
                          name: name,
                          email: email,
                          password: password,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Don't have an account yet ?  Sign Up",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButtonWidget(
                      onClick: () {
                        if (key.currentState?.validate() ?? false) {
                          _authenticationCubit.signIn(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                        }
                      },
                      title: "Login",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_button_widgets.dart';
import '../widgets/custom_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  final Function(String, String, String) onSignUp;

  static const route = AdaptiveRoute(
    page: SignUpScreen,
    path: 'sign_up',
  );
  const SignUpScreen({super.key, required this.onSignUp});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _nameController;
  final key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.clear();
    _passwordController.clear();
    _nameController.clear();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'Name',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          CustomTextFormField(
                            controller: _nameController,
                            textInputAction: TextInputAction.next,
                            maxLines: 1,
                            hintText: 'Your name',
                            hasClearButton: true,
                            validator: (value) {
                              if (value == '') {
                                return 'Enter an name';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Column(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'Password',
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.w500),
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
              SizedBox(
                width: double.infinity,
                child: CustomButtonWidget(
                  onClick: () {
                    if (key.currentState?.validate() ?? false) {
                      widget.onSignUp.call(
                        _emailController.text,
                        _passwordController.text,
                        _nameController.text,
                      );
                      AutoRouter.of(context).pop();
                    }
                  },
                  title: "Submit",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

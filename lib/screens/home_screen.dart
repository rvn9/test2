import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app2/routes/router.gr.dart';

import '../bloc/authentication/authentication_cubit.dart';
import '../widgets/custom_button_widgets.dart';

class HomeScreen extends StatefulWidget {
  static const route = AdaptiveRoute(
    page: HomeScreen,
    path: 'home',
  );
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final AuthenticationCubit _authenticationCubit;

  @override
  void initState() {
    super.initState();
    _authenticationCubit = AuthenticationCubit.create();
  }

  @override
  void dispose() {
    _authenticationCubit.close();
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
            signOut: () =>
                AutoRouter.of(context).replace(const SignInScreenRoute()),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Home page'),
              CustomButtonWidget(
                onClick: () => _authenticationCubit.signOut(),
                title: "Sign Out",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

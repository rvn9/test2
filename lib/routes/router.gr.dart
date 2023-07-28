// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:test_app2/auth_guard.dart' as _i6;
import 'package:test_app2/screens/home_screen.dart' as _i3;
import 'package:test_app2/screens/sign_in_screen.dart' as _i1;
import 'package:test_app2/screens/sign_up_screen.dart' as _i2;

class AppRouters extends _i4.RootStackRouter {
  AppRouters({
    _i5.GlobalKey<_i5.NavigatorState>? navigatorKey,
    required this.authGuard,
  }) : super(navigatorKey);

  final _i6.AuthGuard authGuard;

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    SignInScreenRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.SignInScreen(),
        opaque: true,
      );
    },
    SignUpScreenRoute.name: (routeData) {
      final args = routeData.argsAs<SignUpScreenRouteArgs>();
      return _i4.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i2.SignUpScreen(
          key: args.key,
          onSignUp: args.onSignUp,
        ),
        opaque: true,
      );
    },
    HomeScreenRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomeScreen(),
        opaque: true,
      );
    },
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: 'sign_in',
          fullMatch: true,
        ),
        _i4.RouteConfig(
          SignInScreenRoute.name,
          path: 'sign_in',
          guards: [authGuard],
        ),
        _i4.RouteConfig(
          SignUpScreenRoute.name,
          path: 'sign_up',
        ),
        _i4.RouteConfig(
          HomeScreenRoute.name,
          path: 'home',
        ),
      ];
}

/// generated route for
/// [_i1.SignInScreen]
class SignInScreenRoute extends _i4.PageRouteInfo<void> {
  const SignInScreenRoute()
      : super(
          SignInScreenRoute.name,
          path: 'sign_in',
        );

  static const String name = 'SignInScreenRoute';
}

/// generated route for
/// [_i2.SignUpScreen]
class SignUpScreenRoute extends _i4.PageRouteInfo<SignUpScreenRouteArgs> {
  SignUpScreenRoute({
    _i5.Key? key,
    required dynamic Function(
      String,
      String,
      String,
    ) onSignUp,
  }) : super(
          SignUpScreenRoute.name,
          path: 'sign_up',
          args: SignUpScreenRouteArgs(
            key: key,
            onSignUp: onSignUp,
          ),
        );

  static const String name = 'SignUpScreenRoute';
}

class SignUpScreenRouteArgs {
  const SignUpScreenRouteArgs({
    this.key,
    required this.onSignUp,
  });

  final _i5.Key? key;

  final dynamic Function(
    String,
    String,
    String,
  ) onSignUp;

  @override
  String toString() {
    return 'SignUpScreenRouteArgs{key: $key, onSignUp: $onSignUp}';
  }
}

/// generated route for
/// [_i3.HomeScreen]
class HomeScreenRoute extends _i4.PageRouteInfo<void> {
  const HomeScreenRoute()
      : super(
          HomeScreenRoute.name,
          path: 'home',
        );

  static const String name = 'HomeScreenRoute';
}

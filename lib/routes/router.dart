import 'package:auto_route/auto_route.dart';
import 'package:test_app2/screens/home_screen.dart';
import 'package:test_app2/screens/sign_in_screen.dart';
import 'package:test_app2/screens/sign_up_screen.dart';

@AdaptiveAutoRouter(routes: <AutoRoute>[
  SignInScreen.route,
  SignUpScreen.route,
  HomeScreen.route,
])
class $AppRouters {}

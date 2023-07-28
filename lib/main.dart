import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_app2/auth_guard.dart';
import 'package:test_app2/inejctor.dart';

import 'routes/router.gr.dart';

void runTestApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injector.initialize();
  runApp(const TestApp2());
}

void main() {
  runTestApp();
}

class TestApp2 extends StatelessWidget {
  const TestApp2({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouters(authGuard: AuthGuard());
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child) => MaterialApp.router(
        routerDelegate: appRouter.delegate(),
        routeInformationParser: appRouter.defaultRouteParser(),
      ),
    );
  }
}

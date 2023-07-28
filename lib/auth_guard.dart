import 'package:auto_route/auto_route.dart';

import 'data/local/secure_storage.dart';
import 'routes/router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final secureStorage = SecureStorge();
    final token = await secureStorage.getToken();
    if (token != null) {
      router.push(const HomeScreenRoute());
    } else {
      resolver.next(true);
    }
  }
}

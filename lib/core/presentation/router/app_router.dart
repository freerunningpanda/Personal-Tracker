import 'package:auto_route/auto_route.dart';
import 'package:tracker/core/presentation/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')

/// [AppRouter] is a class that extends [RootStackRouter].
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: MainRoute.page,
          initial: true,
        ),
      ];
}

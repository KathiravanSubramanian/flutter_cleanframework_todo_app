import 'package:clean_framework_router/clean_framework_router.dart';
import '../features/features.dart';
import 'routes.dart';

class ProjectRouter extends AppRouter<Routes> {
  @override
  RouterConfiguration configureRouter() {
    return RouterConfiguration(
      // debugLogDiagnostics: true,
      routes: [
        AppRoute(
          route: Routes.splash,
          builder: (_, __) => SplashUI(),
          routes: [
            AppRoute(
              route: Routes.todoList,
              builder: (_, __) => TodoListUI(),
              routes: [
                AppRoute(
                  route: Routes.todoForm,
                  builder: (_, state) {
                    return TodoFormUI(
                        inputType: state.extra as Map<String, dynamic>);
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_router/clean_framework_router.dart';
import 'package:flutter/material.dart';

import 'src/core/core.dart';
import 'src/features/features.dart';
import 'src/routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme();

    return AppScope(
      child: AppProviderScope(
        externalInterfaceProviders: const [],
        child: AppRouterScope(
          create: ProjectRouter.new,
          builder: (context) {
            return MaterialApp.router(
              routerConfig: context.router.config,
              title: AppStrings.appName,
              theme: theme.buildLightTheme(),
              darkTheme: theme.buildDarkTheme(),
              themeMode: ThemeMode.system,
              debugShowCheckedModeBanner: false,
            );
          },
        ),
      ),
    );
  }
}

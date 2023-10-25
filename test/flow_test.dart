import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_router/clean_framework_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cleanframework_todo_app/src/core/core.dart';
import 'package:flutter_cleanframework_todo_app/src/features/features.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoForm/providers/todo_form_external_interface_providers.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoList/providers/todo_list_external_interface_providers.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoList/widgets/todo_card.dart';
import 'package:flutter_cleanframework_todo_app/src/routes/routes.dart';
import 'package:flutter_test/flutter_test.dart';

import 'src/external_interface_fake/todo_create_external_interface_fake.dart';
import 'src/external_interface_fake/todo_delete_external_interface_fake.dart';
import 'src/external_interface_fake/todo_read_external_interface_fake.dart';
import 'src/external_interface_fake/todo_update_external_interface_fake.dart';

void main() {
  testWidgets('Flow Test', (tester) async {
    final widget = AppScope(
      child: AppProviderScope(
        externalInterfaceProviders: [
          readExternalInterfaceProvider,
        ],
        overrides: [
          createExternalInterfaceProvider
              .overrideWith(TodoCreateExternalInterfaceFake()),
          readExternalInterfaceProvider.overrideWith(
            TodoReadExternalInterfaceFake(),
          ),
          updateExternalInterfaceProvider
              .overrideWith(TodoUpdateExternalInterfaceFake()),
          deleteExternalInterfaceProvider
              .overrideWith(TodoDeleteExternalInterfaceFake()),
        ],
        child: AppRouterScope(
          create: ProjectRouter.new,
          builder: (context) {
            AppTheme theme = AppTheme();
            return MaterialApp.router(
              routerConfig: context.router.config,
              theme: theme.buildLightTheme(),
              darkTheme: theme.buildDarkTheme(),
              themeMode: ThemeMode.system,
            );
          },
        ),
      ),
    );

    await tester.pumpWidget(widget);
    await tester.pump(const Duration(seconds: 2));
    expect(find.byType(SplashUI), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
    expect(find.byType(TodoListUI), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump(const Duration(seconds: 2));
    final NavigatorState navigator = tester.state(find.byType(Navigator));
    navigator.pop();
    await tester.pump(const Duration(seconds: 2));
    expect(find.byType(TodoListUI), findsOneWidget);
    final todoCard = find.byType(TodoCard).evaluate().first.widget as TodoCard;
    expect(todoCard.todo.title, 'welcome');
    await tester.pump(const Duration(seconds: 2));

    await tester.fling(find.text('welcome'), const Offset(0, 400), 800);
    expect(
      tester.getSemantics(find.byType(RefreshProgressIndicator)),
      matchesSemantics(label: 'Refresh'),
    );

    await tester.pumpAndSettle();
  });
}

import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_router/clean_framework_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cleanframework_todo_app/src/features/features.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoForm/providers/todo_form_external_interface_providers.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoList/providers/todo_list_external_interface_providers.dart';
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
            return MaterialApp.router(
              routerConfig: context.router.config,
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
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.byType(TodoFormUI), findsOneWidget);
  });
}

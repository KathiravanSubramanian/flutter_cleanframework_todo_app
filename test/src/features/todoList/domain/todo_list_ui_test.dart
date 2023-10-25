import 'package:clean_framework_router/clean_framework_router.dart';
import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoList/model/todo_model.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoList/presentation/todo_list_ui.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoList/presentation/todo_list_view_model.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoList/widgets/todo_card.dart';
import 'package:flutter_cleanframework_todo_app/src/features/widgets/app_scope.dart';
import 'package:flutter_cleanframework_todo_app/src/routes/routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final todoList = [
    TodoModel(
      id: '45',
      title: 'welcome',
      description: 'welcome 2',
      isCompleted: false,
      createdAt: '',
      updatedAt: '',
    ),
    TodoModel(
      id: '25',
      title: 'todo title',
      description: 'todo description 2',
      isCompleted: false,
      createdAt: '',
      updatedAt: '',
    ),
  ];
  final vm = TodoListViewModel(
    todoList: todoList,
    isLoading: false,
    hasFailedLoading: false,
    onRetry: () {},
    onRefresh: () async {},
    deleteById: (String value) {},
  );
  group('TodoListUI tests |', () {
    uiTest(
      'shows todo list correctly',
      ui: TodoListUI(),
      viewModel: TodoListViewModel(
        todoList: todoList,
        isLoading: false,
        hasFailedLoading: false,
        onRetry: () {},
        onRefresh: () async {},
        deleteById: (String value) {},
      ),
      verify: (tester) async {
        expect(find.text('welcome'), findsOneWidget);
        expect(find.text('todo title'), findsOneWidget);
      },
    );

    uiTest(
      'shows loading indicator if loading data',
      ui: TodoListUI(),
      viewModel: TodoListViewModel(
        todoList: const [],
        isLoading: true,
        hasFailedLoading: false,
        onRetry: () {},
        onRefresh: () async {},
        deleteById: (String value) {},
      ),
      verify: (tester) async {
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    uiTest(
      'shows loading failed widget if data failed loading',
      ui: TodoListUI(),
      viewModel: TodoListViewModel(
        todoList: const [],
        isLoading: false,
        hasFailedLoading: true,
        onRetry: () {},
        onRefresh: () async {},
        deleteById: (String value) {},
      ),
      verify: (tester) async {
        expect(
            find.text(
                'Unable to connect to server. Check your network connections or try again later.'),
            findsOneWidget);
      },
    );

    uiTest(
      'Delete the item from the list',
      builder: (context, child) {
        return AppScope(
          child: child,
        );
      },
      ui: TodoListUI(),
      viewModel: vm,
      verify: (tester) async {
        await tester.pumpAndSettle();
        final todoCardFinder = find.descendant(
          of: find.byType(TodoCard),
          matching: find.text('welcome'),
        );
        expect(todoCardFinder, findsOneWidget);

        await tester.pumpAndSettle();

        final listItem = find.widgetWithText(ListTile, 'welcome');

        expect(listItem, findsOneWidget);
        await tester.pump();

        expect(find.byType(ListTile), findsNWidgets(2));

        await tester.tap(find.byType(PopupMenuButton<String>).first);
        await tester.pumpAndSettle();
        expect(find.text('Edit'), findsOneWidget);
        expect(find.text('Delete'), findsOneWidget);
        await tester.tap(find.text('Delete'));
        await tester.pump();

        // Verify that the alert dialog is displayed
        final alertDialog = find.byType(AlertDialog);
        expect(alertDialog, findsOneWidget);

        final alertText = find.text('Are you sure you want to delete?');
        expect(alertText, findsOneWidget);

        final cancelBtn = find.text('Cancel');
        final deleteBtn = find.text('Delete Item');
        expect(cancelBtn, findsOneWidget);
        expect(deleteBtn, findsOneWidget);

        await tester.tap(deleteBtn);
        await tester.pumpAndSettle();

        expect(alertDialog, findsNothing);
      },
    );

    uiTest(
      'Cancel alert dialog delete the item from the list',
      builder: (context, child) {
        return AppScope(
          child: child,
        );
      },
      ui: TodoListUI(),
      viewModel: vm,
      verify: (tester) async {
        await tester.pumpAndSettle();
        final todoCardFinder = find.descendant(
          of: find.byType(TodoCard),
          matching: find.text('welcome'),
        );
        expect(todoCardFinder, findsOneWidget);

        await tester.pumpAndSettle();

        final listItem = find.widgetWithText(ListTile, 'welcome');

        expect(listItem, findsOneWidget);
        await tester.pump();

        expect(find.byType(ListTile), findsNWidgets(2));

        await tester.tap(find.byType(PopupMenuButton<String>).first);
        await tester.pumpAndSettle();
        expect(find.text('Edit'), findsOneWidget);
        expect(find.text('Delete'), findsOneWidget);
        await tester.tap(find.text('Delete'));
        await tester.pump();

        // Verify that the alert dialog is displayed
        final alertDialog = find.byType(AlertDialog);
        expect(alertDialog, findsOneWidget);

        final alertText = find.text('Are you sure you want to delete?');
        expect(alertText, findsOneWidget);

        final cancelBtn = find.text('Cancel');
        final deleteBtn = find.text('Delete Item');
        expect(cancelBtn, findsOneWidget);
        expect(deleteBtn, findsOneWidget);

        await tester.tap(cancelBtn);
        await tester.pumpAndSettle();

        expect(alertDialog, findsNothing);
      },
    );
  });

  uiTest(
    'Edit the item from the list',
    builder: (context, child) {
      return AppScope(
        child: child,
      );
    },
    ui: TodoListUI(),
    viewModel: vm,
    verify: (tester) async {
      await tester.pumpAndSettle();
      final todoCardFinder = find.descendant(
        of: find.byType(TodoCard),
        matching: find.text('welcome'),
      );
      expect(todoCardFinder, findsOneWidget);

      await tester.pumpAndSettle();

      final listItem = find.widgetWithText(ListTile, 'welcome');

      expect(listItem, findsOneWidget);
      await tester.pump();

      expect(find.byType(ListTile), findsNWidgets(2));

      await tester.tap(find.byType(PopupMenuButton<String>).first);
      await tester.pumpAndSettle();
      expect(find.text('Edit'), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
      await tester.tap(find.text('Edit'));
      await tester.pump();

      final routeData = tester.routeData!;
      expect(routeData.route, Routes.todoForm);
      expect(
          routeData.extra,
          equals({
            'id': '45',
            'title': 'welcome',
            'description': 'welcome 2',
            'isCompleted': false
          }));

      tester.element(find.byType(MaterialApp)).router.pop();
      await tester.pumpAndSettle();

      final poppedRouteData = tester.poppedRouteData!;
      expect(poppedRouteData.route, Routes.todoForm);
      expect(
          poppedRouteData.extra,
          equals({
            'id': '45',
            'title': 'welcome',
            'description': 'welcome 2',
            'isCompleted': false
          }));
    },
  );
}

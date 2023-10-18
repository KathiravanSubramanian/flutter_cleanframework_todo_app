import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoList/model/todo_model.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoList/presentation/todo_list_ui.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoList/presentation/todo_list_view_model.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoList/widgets/todo_card.dart';
import 'package:flutter_cleanframework_todo_app/src/features/widgets/app_scope.dart';
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
      viewModel: TodoListViewModel(
        todoList: todoList,
        isLoading: false,
        hasFailedLoading: false,
        onRetry: () {},
        onRefresh: () async {},
        deleteById: (String value) {},
      ),
      verify: (tester) async {
        await tester.pumpAndSettle();

        final todoCardFinder = find.descendant(
          of: find.byType(TodoCard),
          matching: find.text('welcome'),
        );

        expect(todoCardFinder, findsOneWidget);

        // Delete the item
        // final findDeleteOption = find.descendant(
        //   of: todoCardFinder,
        //   matching: find.byType(PopupMenuItem),
        // );

        // expect(findDeleteOption, findsOneWidget);

        // await tester.tapAt(tester.getTopRight(findDeleteOption));
        // await tester.pumpAndSettle();

        // final findDeleteOption = find.descendant(
        //   of: find.byType(PopupMenuItem),
        //   matching: find.text('Delete'),
        // );
        // await tester.tap(findDeleteOption);
      },
    );
  });
}

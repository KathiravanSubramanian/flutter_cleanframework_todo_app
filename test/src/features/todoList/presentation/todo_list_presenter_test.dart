import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoList/domain/todo_list_entity.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoList/domain/todo_list_ui_output.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoList/domain/todo_list_use_case.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoList/model/todo_model.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoList/presentation/todo_list_presenter.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoList/presentation/todo_list_view_model.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoList/providers/todo_list_use_case_providers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

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
  group('TodoListPresenter tests |', () {
    presenterTest<TodoListViewModel, TodoListUIOutput, TodoListUseCase>(
      'creates proper view model',
      create: (builder) => TodoListPresenter(builder: builder),
      overrides: [
        todoListUseCaseProvider.overrideWith(TodoListUseCaseFake()),
      ],
      setup: (useCase) {
        useCase.debugEntityUpdate(
          (e) => e.copyWith(
            todoList: todoList,
          ),
        );
      },
      expect: () => [
        isA<TodoListViewModel>().having((vm) => vm.todoList, 'todoList', []),
        isA<TodoListViewModel>().having(
          (vm) => vm.todoList.map((p) => p.title),
          'todoList',
          ['welcome', 'todo title'],
        ),
      ],
    );

    presenterTest<TodoListViewModel, TodoListUIOutput, TodoListUseCase>(
      'shows success snack bar if delete fails',
      create: (builder) => TodoListPresenter(builder: builder),
      overrides: [
        todoListUseCaseProvider.overrideWith(TodoListUseCaseFake()),
      ],
      setup: (useCase) {
        useCase.debugEntityUpdate(
          (e) => e.copyWith(
            isDeleted: true,
            status: TodoListStatus.failed,
          ),
        );
      },
      verify: (tester) {
        expect(
          find.text('Sorry, failed to delete this todo!'),
          findsOneWidget,
        );
      },
    );

    presenterTest<TodoListViewModel, TodoListUIOutput, TodoListUseCase>(
      'shows failure snack bar if delete success',
      create: (builder) => TodoListPresenter(builder: builder),
      overrides: [
        todoListUseCaseProvider.overrideWith(TodoListUseCaseFake()),
      ],
      setup: (useCase) {
        useCase.debugEntityUpdate(
          (e) => e.copyWith(
            isDeleted: true,
            status: TodoListStatus.loaded,
          ),
        );
      },
      verify: (tester) {
        expect(
          find.text('Deleted successfully!'),
          findsOneWidget,
        );
      },
    );

    presenterTest<TodoListViewModel, TodoListUIOutput, TodoListUseCase>(
      'shows success snack bar if refreshing fails',
      create: (builder) => TodoListPresenter(builder: builder),
      overrides: [
        todoListUseCaseProvider.overrideWith(TodoListUseCaseFake()),
      ],
      setup: (useCase) {
        useCase.debugEntityUpdate(
          (e) => e.copyWith(
            isRefresh: true,
            status: TodoListStatus.loaded,
          ),
        );
      },
      verify: (tester) {
        expect(
          find.text('Refreshed Todo`s successfully!'),
          findsOneWidget,
        );
      },
    );

    presenterTest<TodoListViewModel, TodoListUIOutput, TodoListUseCase>(
      'shows failure snack bar if refreshing fails',
      create: (builder) => TodoListPresenter(builder: builder),
      overrides: [
        todoListUseCaseProvider.overrideWith(TodoListUseCaseFake()),
      ],
      setup: (useCase) {
        useCase.debugEntityUpdate(
          (e) => e.copyWith(
            isRefresh: true,
            status: TodoListStatus.failed,
          ),
        );
      },
      verify: (tester) {
        expect(
          find.text('Sorry, failed refreshing Todo`s!'),
          findsOneWidget,
        );
      },
    );

    presenterCallbackTest<TodoListViewModel, TodoListUIOutput, TodoListUseCase>(
      'calls refresh fetchData in use case',
      useCase: TodoListUseCaseMock(),
      create: (builder) => TodoListPresenter(builder: builder),
      setup: (useCase) {
        when(() => useCase.fetchData(isRefresh: true)).thenAnswer((_) async {});
      },
      verify: (useCase, vm) {
        vm.onRefresh();

        verify(() => useCase.fetchData(isRefresh: true));
      },
    );

    presenterCallbackTest<TodoListViewModel, TodoListUIOutput, TodoListUseCase>(
      'calls deleteById in use case',
      useCase: TodoListUseCaseMock(),
      create: (builder) => TodoListPresenter(builder: builder),
      setup: (useCase) {
        when(() => useCase.deleteById('45')).thenAnswer((_) async {});
      },
      verify: (useCase, vm) {
        vm.deleteById('45');

        verify(() => useCase.deleteById('45'));
      },
    );
  });
}

class TodoListUseCaseFake extends TodoListUseCase {
  @override
  Future<void> fetchData({bool isRefresh = false}) async {}
}

class TodoListUseCaseMock extends UseCaseMock<TodoListEntity>
    implements TodoListUseCase {
  TodoListUseCaseMock()
      : super(
          entity: const TodoListEntity(),
          transformers: [TodoListUIOutputTransformer()],
        );
}

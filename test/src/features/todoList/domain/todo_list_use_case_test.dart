import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoList/domain/todo_list_entity.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoList/domain/todo_list_ui_output.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoList/domain/todo_list_use_case.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoList/gateway/todo_delete_gateway.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoList/gateway/todo_read_gateway.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoList/model/todo_model.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoList/providers/todo_list_use_case_providers.dart';
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
  group('TodoListUseCase test |', () {
    group('ReadUseCase |', () {
      useCaseTest<TodoListUseCase, TodoListEntity, TodoListUIOutput>(
        'fetchData; success',
        provider: todoListUseCaseProvider,
        execute: (useCase) {
          _mockSuccess(useCase, 'read');

          return useCase.fetchData();
        },
        expect: () => [
          const TodoListUIOutput(
            todoList: [],
            status: TodoListStatus.loading,
            isRefresh: false,
            isDeleted: false,
          ),
          TodoListUIOutput(
            todoList: todoList,
            status: TodoListStatus.loaded,
            isRefresh: false,
            isDeleted: false,
          ),
        ],
        verify: (useCase) {
          expect(
            useCase.debugEntity,
            TodoListEntity(todoList: todoList, status: TodoListStatus.loaded),
          );
        },
      );

      useCaseTest<TodoListUseCase, TodoListEntity, TodoListUIOutput>(
        'refresh fetchData; success',
        provider: todoListUseCaseProvider,
        execute: (useCase) {
          _mockSuccess(useCase, 'read');

          return useCase.fetchData(isRefresh: true);
        },
        expect: () {
          return [
            TodoListUIOutput(
              todoList: todoList,
              status: TodoListStatus.loaded,
              isRefresh: true,
              isDeleted: false,
            ),
            TodoListUIOutput(
              todoList: todoList,
              status: TodoListStatus.loaded,
              isRefresh: false,
              isDeleted: false,
            ),
          ];
        },
      );

      useCaseTest<TodoListUseCase, TodoListEntity, TodoListUIOutput>(
        'fetchData; failure',
        provider: todoListUseCaseProvider,
        execute: (useCase) {
          _mockFailure(useCase, 'read');

          return useCase.fetchData();
        },
        expect: () => [
          const TodoListUIOutput(
            todoList: [],
            status: TodoListStatus.loading,
            isRefresh: false,
            isDeleted: false,
          ),
          const TodoListUIOutput(
            todoList: [],
            status: TodoListStatus.failed,
            isRefresh: false,
            isDeleted: false,
          ),
        ],
      );

      useCaseTest<TodoListUseCase, TodoListEntity, TodoListUIOutput>(
        'refresh fetchData; failure',
        provider: todoListUseCaseProvider,
        execute: (useCase) {
          _mockFailure(useCase, 'read');

          return useCase.fetchData(isRefresh: true);
        },
        expect: () => [
          const TodoListUIOutput(
            todoList: [],
            status: TodoListStatus.failed,
            isRefresh: true,
            isDeleted: false,
          ),
          const TodoListUIOutput(
            todoList: [],
            status: TodoListStatus.loaded,
            isRefresh: false,
            isDeleted: false,
          ),
        ],
      );
    });

    group('DeleteUseCase |', () {
      useCaseTest<TodoListUseCase, TodoListEntity, TodoListUIOutput>(
        'deleteById; success',
        provider: todoListUseCaseProvider,
        execute: (useCase) {
          _mockSuccess(useCase, 'delete');
          return useCase.deleteById('45');
        },
        expect: () => [
          const TodoListUIOutput(
            todoList: [],
            status: TodoListStatus.loading,
            isRefresh: false,
            isDeleted: false,
          ),
          const TodoListUIOutput(
            todoList: [],
            status: TodoListStatus.loaded,
            isRefresh: false,
            isDeleted: true,
          ),
        ],
        verify: (useCase) {
          expect(
            useCase.debugEntity,
            const TodoListEntity(
                todoList: [], isDeleted: true, status: TodoListStatus.loaded),
          );
        },
      );

      useCaseTest<TodoListUseCase, TodoListEntity, TodoListUIOutput>(
        'deleteById; failure',
        provider: todoListUseCaseProvider,
        execute: (useCase) {
          _mockFailure(useCase, 'delete');
          return useCase.deleteById('45');
        },
        expect: () => [
          const TodoListUIOutput(
            todoList: [],
            status: TodoListStatus.loading,
            isRefresh: false,
            isDeleted: false,
          ),
          const TodoListUIOutput(
            todoList: [],
            status: TodoListStatus.failed,
            isRefresh: false,
            isDeleted: false,
          ),
        ],
      );
    });
  });
}

void _mockSuccess(TodoListUseCase useCase, String inputType) {
  if (inputType == 'read') {
    useCase.subscribe<TodoReadGatewayOutput, TodoReadSuccessInput>(
      (_) async {
        return Either.right(
          TodoReadSuccessInput(
            todoIdentities: [
              TodoIdentity(
                id: '45',
                title: 'welcome',
                description: 'welcome 2',
                isCompleted: false,
                createdAt: '',
                updatedAt: '',
              ),
              TodoIdentity(
                id: '25',
                title: 'todo title',
                description: 'todo description 2',
                isCompleted: false,
                createdAt: '',
                updatedAt: '',
              ),
            ],
          ),
        );
      },
    );
  } else if (inputType == 'delete') {
    useCase.subscribe<TodoDeleteGatewayOutput, TodoDeleteSuccessInput>(
      (_) async {
        return Either.right(
          TodoDeleteSuccessInput(
            todo: TodoIdentity(
              id: '45',
              title: 'welcome',
              description: 'welcome 2',
              isCompleted: false,
              createdAt: '',
              updatedAt: '',
            ),
          ),
        );
      },
    );
  }
}

void _mockFailure(TodoListUseCase useCase, String inputType) {
  if (inputType == 'read') {
    useCase.subscribe<TodoReadGatewayOutput, TodoReadSuccessInput>(
      (_) async {
        return const Either.left(FailureInput(message: 'No Internet'));
      },
    );
  } else if (inputType == 'delete') {
    useCase.subscribe<TodoDeleteGatewayOutput, TodoDeleteSuccessInput>(
      (_) async {
        return const Either.left(FailureInput(message: 'No Internet'));
      },
    );
  }
}

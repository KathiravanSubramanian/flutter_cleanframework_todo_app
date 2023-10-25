import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoForm/domain/todo_form_entity.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoForm/domain/todo_form_ui_output.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoForm/domain/todo_form_use_case.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoForm/gateway/todo_create_gateway.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoForm/gateway/todo_update_gateway.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoForm/providers/todo_form_use_case_providers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TodoFormUseCase test |', () {
    group('CreateUseCase |', () {
      useCaseTest<TodoFormUseCase, TodoFormEntity, TodoFormUIOutput>(
        'create; success',
        provider: todoFormUseCaseProvider,
        execute: (useCase) {
          _mockSuccess(useCase, 'create');
          return useCase.createTodo();
        },
        expect: () => [
          const TodoFormUIOutput(
            status: TodoFormStatus.loading,
          ),
          const TodoFormUIOutput(
            status: TodoFormStatus.loaded,
          ),
        ],
        verify: (useCase) {
          expect(
            useCase.debugEntity,
            const TodoFormEntity(
              status: TodoFormStatus.loaded,
            ),
          );
        },
      );

      useCaseTest<TodoFormUseCase, TodoFormEntity, TodoFormUIOutput>(
        'create; failure',
        provider: todoFormUseCaseProvider,
        execute: (useCase) {
          _mockFailure(useCase, 'create');
          return useCase.createTodo();
        },
        expect: () => [
          const TodoFormUIOutput(status: TodoFormStatus.loading),
          const TodoFormUIOutput(
            status: TodoFormStatus.failed,
          ),
        ],
      );
    });
    group('UpdateUseCase |', () {
      useCaseTest<TodoFormUseCase, TodoFormEntity, TodoFormUIOutput>(
        'update; success',
        provider: todoFormUseCaseProvider,
        execute: (useCase) {
          _mockSuccess(useCase, 'update');
          return useCase.updateById('45');
        },
        expect: () => [
          const TodoFormUIOutput(status: TodoFormStatus.loading),
          const TodoFormUIOutput(
            status: TodoFormStatus.loaded,
          ),
        ],
        verify: (useCase) {
          expect(
            useCase.debugEntity,
            const TodoFormEntity(
              status: TodoFormStatus.loaded,
            ),
          );
        },
      );

      useCaseTest<TodoFormUseCase, TodoFormEntity, TodoFormUIOutput>(
        'update; failure',
        provider: todoFormUseCaseProvider,
        execute: (useCase) {
          useCase.loadData({
            'id': '45',
            'title': 'title',
            'description': 'description',
            'isCompleted': false,
          });
          _mockFailure(useCase, 'update');
          return useCase.updateById('45');
        },
        expect: () => [
          const TodoFormUIOutput(status: TodoFormStatus.loading),
          const TodoFormUIOutput(
            status: TodoFormStatus.failed,
          ),
        ],
      );
    });
  });
}

void _mockSuccess(TodoFormUseCase useCase, String inputType) {
  if (inputType == 'create') {
    useCase.subscribe<TodoCreateGatewayOutput, TodoCreateSuccessInput>(
      (_) async {
        return Either.right(
          TodoCreateSuccessInput(
            id: '',
            title: '',
            description: '',
            isCompleted: false,
            createdAt: '',
            updatedAt: '',
          ),
        );
      },
    );
  } else if (inputType == 'update') {
    useCase.subscribe<TodoUpdateGatewayOutput, TodoUpdateSuccessInput>(
      (_) async {
        return Either.right(
          TodoUpdateSuccessInput(
              id: '',
              title: '',
              description: '',
              isCompleted: false,
              createdAt: '',
              updatedAt: ''),
        );
      },
    );
  }
}

void _mockFailure(TodoFormUseCase useCase, String inputType) {
  if (inputType == 'create') {
    useCase.subscribe<TodoCreateGatewayOutput, TodoCreateSuccessInput>(
      (_) async {
        return const Either.left(FailureInput(message: 'No Internet'));
      },
    );
  } else if (inputType == 'update') {
    useCase.subscribe<TodoUpdateGatewayOutput, TodoUpdateSuccessInput>(
      (_) async {
        return const Either.left(FailureInput(message: 'No Internet'));
      },
    );
  }
}

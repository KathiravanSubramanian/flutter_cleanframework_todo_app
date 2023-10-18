import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoForm/domain/todo_form_entity.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoForm/domain/todo_form_ui_output.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoForm/domain/todo_form_use_case.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoForm/presentation/todo_form_presenter.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoForm/presentation/todo_form_view_model.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoForm/providers/todo_form_use_case_providers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TodoFormPresenter tests |', () {
    presenterTest<TodoFormViewModel, TodoFormUIOutput, TodoFormUseCase>(
      'creates proper view model',
      create: (builder) => TodoFormPresenter(
        builder: builder,
        inputType: const {},
      ),
      overrides: [
        todoFormUseCaseProvider.overrideWith(TodoFormUseCaseFake()),
      ],
      setup: (useCase) {
        useCase.debugEntityUpdate(
          (e) => e.copyWith(
            title: 'welcome',
          ),
        );
      },
      // expect: () => [
      //   isA<TodoFormViewModel>().having((vm) => vm.isLoading, false, false),
      // ],
    );
  });
}

class TodoFormUseCaseFake extends TodoFormUseCase {}

class TodoListUseCaseMock extends UseCaseMock<TodoFormEntity>
    implements TodoFormUseCase {
  TodoListUseCaseMock()
      : super(
          entity: const TodoFormEntity(),
          transformers: [TodoFormUIOutputTransformer()],
        );
}

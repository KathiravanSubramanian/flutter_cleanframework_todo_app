import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoForm/domain/todo_form_entity.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoForm/domain/todo_form_ui_output.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoForm/domain/todo_form_use_case.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoForm/presentation/todo_form_presenter.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoForm/presentation/todo_form_view_model.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoForm/providers/todo_form_use_case_providers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TodoFormPresenter tests ', () {
    Map<String, dynamic> inputType = {
      'id': '',
      'title': '',
      'description': '',
      'isCompleted': false
    };
    presenterTest<TodoFormViewModel, TodoFormUIOutput, TodoFormUseCase>(
      'Create Form view model',
      create: (builder) =>
          TodoFormPresenter(builder: builder, inputType: inputType),
      overrides: [
        todoFormUseCaseProvider.overrideWith(TodoFormUseCaseFake()),
      ],
      setup: (useCase) {
        useCase.debugEntityUpdate(
          (e) => e.copyWith(
              id: inputType['id'],
              title: inputType['title'],
              description: inputType['description'],
              isCompleted: inputType['isCompleted'],
              updatedAt: '',
              createdAt: '',
              status: TodoFormStatus.initial,
              formController: FormController()),
        );
      },
      expect: () => [
        isA<TodoFormViewModel>()
            .having((vm) => vm.isLoading, 'Loading check', false),
      ],
    );
  });
}

class TodoFormUseCaseFake extends TodoFormUseCase {
  @override
  Future<void> createTodo() async {}
  @override
  Future<void> updateById(String id) async {}
}

class TodoFormUseCaseMock extends UseCaseMock<TodoFormEntity>
    implements TodoFormUseCase {
  TodoFormUseCaseMock()
      : super(
          entity: const TodoFormEntity(),
          transformers: [
            TodoFormUIOutputTransformer(),
            TodoFormInputTransformer(),
          ],
        );
}

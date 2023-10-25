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

    Map<String, dynamic> inputTypeWithData = {
      'id': '45',
      'title': 'welcome',
      'description': 'welcome description',
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

    presenterTest<TodoFormViewModel, TodoFormUIOutput, TodoFormUseCase>(
      'shows failure snack bar if create fails',
      create: (builder) =>
          TodoFormPresenter(builder: builder, inputType: inputType),
      overrides: [
        todoFormUseCaseProvider.overrideWith(TodoFormUseCaseFake()),
      ],
      setup: (useCase) {
        useCase.debugEntityUpdate(
          (e) => e.copyWith(
            status: TodoFormStatus.failed,
          ),
        );
      },
      verify: (tester) {
        expect(
          find.text('Sorry, failed to create todo!'),
          findsOneWidget,
        );
      },
    );

    presenterTest<TodoFormViewModel, TodoFormUIOutput, TodoFormUseCase>(
      'shows failure snack bar if update fails',
      create: (builder) =>
          TodoFormPresenter(builder: builder, inputType: inputTypeWithData),
      overrides: [
        todoFormUseCaseProvider.overrideWith(TodoFormUseCaseFake()),
      ],
      setup: (useCase) {
        useCase.debugEntityUpdate(
          (e) => e.copyWith(
            status: TodoFormStatus.failed,
          ),
        );
      },
      verify: (tester) {
        expect(
          find.text('Sorry, failed to update todo!'),
          findsOneWidget,
        );
      },
    );
  });
}

class TodoFormUseCaseFake extends TodoFormUseCase {
  @override
  Future<void> loadData(Map<String, dynamic> todo) async {}

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

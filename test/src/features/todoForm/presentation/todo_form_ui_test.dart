import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cleanframework_todo_app/src/features/features.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoForm/domain/todo_form_entity.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoForm/presentation/todo_form_view_model.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoForm/widgets/fields.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final addInputType = {
    'id': '',
    'title': '',
    'description': '',
    'isCompleted': false
  };
  final updateInputType = {
    'id': '25',
    'title': 'todo title',
    'description': 'todo description 2',
    'isCompleted': false
  };
  final todoFormController = FormController();
  final titleController =
      TextFieldController.create(todoFormController, tag: TodoFormTags.title);
  final descriptionController = TextFieldController.create(todoFormController,
      tag: TodoFormTags.description);

  group('TodoFormUI tests |', () {
    uiTest('Shows ADD form UI correctly',
        ui: TodoFormUI(inputType: addInputType),
        viewModel: TodoFormViewModel(
            formController: todoFormController,
            isLoading: false,
            hasFailedLoading: false,
            createTodo: () {},
            updateById: (String id) {}), verify: (tester) async {
      await tester.pumpAndSettle();
      expect(find.text('Add'), findsNWidgets(2));
    });

    uiTest('Shows ADD form with validation of form',
        ui: TodoFormUI(inputType: addInputType),
        viewModel: TodoFormViewModel(
            formController: todoFormController,
            isLoading: false,
            hasFailedLoading: false,
            createTodo: () {},
            updateById: (String id) {}), verify: (tester) async {
      await tester.pumpAndSettle();

      titleController.setValue('todo title');

      expect(find.text('todo title'), findsOneWidget);

      descriptionController.setValue('todo description 2');

      expect(find.text('todo description 2'), findsOneWidget);

      final addButton = find.byType(FormButton);

      expect(addButton, findsOneWidget);
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      /*  final alertDialog = find.byType(AlertDialog);
          expect(alertDialog, findsOneWidget);

          final alertText = find.text('Has been added successfully');
          expect(alertText, findsOneWidget);*/
    });

    uiTest('Shows ADD form with validation of form',
        ui: TodoFormUI(inputType: addInputType),
        viewModel: TodoFormViewModel(
            formController: todoFormController,
            isLoading: false,
            hasFailedLoading: false,
            createTodo: () {},
            updateById: (String id) {}), verify: (tester) async {
      await tester.pumpAndSettle();

      titleController.setValue('todo title');

      expect(find.text('todo title'), findsOneWidget);

      descriptionController.setValue('todo description 2');

      expect(find.text('todo description 2'), findsOneWidget);

      final addButton = find.byType(FormButton);

      expect(addButton, findsOneWidget);
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      todoFormController.setSubmitted(true);

      await tester.pumpAndSettle();
    });

    uiTest('Form Button enabled test case',
        ui: TodoFormUI(inputType: addInputType),
        viewModel: TodoFormViewModel(
            formController: todoFormController,
            isLoading: false,
            hasFailedLoading: false,
            createTodo: () {},
            updateById: (String id) {}), verify: (tester) async {
      await tester.pumpAndSettle();
      expect(find.text('Add'), findsNWidgets(2));
      final addButton = find.byType(FormButton);
      expect(addButton, findsOneWidget);
      await tester.tap(addButton);
      await tester.pumpAndSettle();
      todoFormController.setSubmitted(true);
      final isEnabled = tester.widget<FormButton>(addButton).onPressed != null;
      expect(isEnabled, isTrue);
      await tester.pumpAndSettle();
      final filledButton = find.byType(FilledButton);
      expect(filledButton, findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.text('Submitting...'), findsOneWidget);
    });

    uiTest('Shows Update UI Form Correctly',
        ui: TodoFormUI(inputType: updateInputType),
        viewModel: TodoFormViewModel(
            formController: todoFormController,
            isLoading: false,
            hasFailedLoading: false,
            createTodo: () {},
            updateById: (String id) {}), verify: (tester) async {
      await tester.pumpAndSettle();
      expect(find.text('Edit'), findsOneWidget);
    });

    uiTest(
      'shows loading indicator if loading data',
      ui: TodoFormUI(inputType: addInputType),
      viewModel: TodoFormViewModel(
          formController: todoFormController,
          isLoading: true,
          hasFailedLoading: false,
          createTodo: () {},
          updateById: (String id) {}),
      verify: (tester) async {
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );
  });
}

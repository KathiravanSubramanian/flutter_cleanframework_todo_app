import 'dart:math';

import 'package:clean_framework/clean_framework.dart';
import 'todo_form_entity.dart';
import 'todo_form_ui_output.dart';

class TodoFormUseCase extends UseCase<TodoFormEntity> {
  TodoFormUseCase()
      : super(
          entity: TodoFormEntity(
            formController: FormController(
              validators: {const InputFieldValidator.required()},
            ),
          ),
          transformers: [
            TodoFormUIOutputTransformer(),
            TodoFormInputTransformer(),
          ],
        ) {
    _titleController = TextFieldController.create(entity.formController,
        tag: TodoFormTags.title);
    _descriptionController = TextFieldController.create(entity.formController,
        tag: TodoFormTags.description);
  }

  late final TextFieldController _titleController;
  late final TextFieldController _descriptionController;

  Future<void> loadData(Map<String, dynamic> todo) async {
    _titleController.setValue(todo['title']);
    _descriptionController.setValue(todo['description']);
  }

  Future<void> createTodo() async {
    final formController = entity.formController;
    if (formController.validate()) {
      formController.setSubmitted(true);
      entity = entity.copyWith(
        status: TodoFormStatus.loading,
      );
      Future.delayed(const Duration(seconds: 2), () {
        entity = entity.copyWith(
          id: Random().nextInt(20).toString(),
          title: _titleController.value ?? '',
          description: _descriptionController.value ?? '',
          isCompleted: false,
          status: TodoFormStatus.loaded,
        );
        formController.setSubmitted(false);
        _titleController.setValue('');
        _descriptionController.setValue('');
        formController.reset();
      });
    }
  }

  Future<void> updateById(String id) async {
    final formController = entity.formController;
    if (formController.validate()) {
      formController.setSubmitted(true);
      entity = entity.copyWith(
        status: TodoFormStatus.loading,
      );
      Future.delayed(const Duration(seconds: 2), () {
        entity = entity.copyWith(
          id: id,
          title: _titleController.value ?? '',
          description: _descriptionController.value ?? '',
          isCompleted: false,
          status: TodoFormStatus.loaded,
        );
        formController.setSubmitted(false);
      });
    }
  }

  @override
  void dispose() {
    entity.formController.dispose();
    super.dispose();
  }
}

class TodoFormUIOutputTransformer
    extends OutputTransformer<TodoFormEntity, TodoFormUIOutput> {
  @override
  TodoFormUIOutput transform(TodoFormEntity entity) {
    return TodoFormUIOutput(
      status: entity.status,
      id: entity.id,
      title: entity.title,
      description: entity.description,
      isCompleted: entity.isCompleted,
      formController: entity.formController,
    );
  }
}

class TodoFormInput extends SuccessInput {
  TodoFormInput(
      {required this.id,
      required this.title,
      required this.description,
      required this.isCompleted});

  final String id;
  final String title;
  final String description;
  final bool isCompleted;
}

class TodoFormInputTransformer
    extends InputTransformer<TodoFormEntity, TodoFormInput> {
  @override
  TodoFormEntity transform(TodoFormEntity entity, TodoFormInput input) {
    return entity.copyWith(
      id: input.id,
      title: input.title,
      description: input.description,
      isCompleted: input.isCompleted,
    );
  }
}

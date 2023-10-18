import 'package:clean_framework/clean_framework.dart';
import '../gateway/todo_create_gateway.dart';
import '../gateway/todo_update_gateway.dart';
import 'todo_form_entity.dart';
import 'todo_form_ui_output.dart';

class TodoFormUseCase extends UseCase<TodoFormEntity> {
  TodoFormUseCase()
      : super(
          entity: const TodoFormEntity(),
          transformers: [
            TodoFormUIOutputTransformer(),
            TodoFormInputTransformer(),
          ],
        ) {
    _titleController =
        TextFieldController.create(todoFormController, tag: TodoFormTags.title);
    _descriptionController = TextFieldController.create(todoFormController,
        tag: TodoFormTags.description);
  }

  late final TextFieldController _titleController;
  late final TextFieldController _descriptionController;
  final todoFormController = FormController(
    validators: {const InputFieldValidator.required()},
  );

  Future<void> loadData(Map<String, dynamic> todo) async {
    _titleController.setValue(todo['title']);
    _descriptionController.setValue(todo['description']);
  }

  Future<void> createTodo() async {
    if (todoFormController.validate()) {
      todoFormController.setSubmitted(true);
      entity = entity.copyWith(
        status: TodoFormStatus.loading,
      );
      request<TodoCreateSuccessInput>(
        TodoCreateGatewayOutput(
            title: _titleController.value ?? '',
            description: _descriptionController.value ?? '',
            isCompleted: false),
        onSuccess: (success) {
          todoFormController.setSubmitted(false);
          _titleController.setValue('');
          _descriptionController.setValue('');
          todoFormController.reset();
          return entity = entity.copyWith(
            id: success.id,
            title: success.title,
            description: success.description,
            isCompleted: success.isCompleted,
            createdAt: success.createdAt,
            updatedAt: success.updatedAt,
            status: TodoFormStatus.loaded,
          );
        },
        onFailure: (failure) => entity.copyWith(
          status: TodoFormStatus.failed,
        ),
      );
    }
  }

  Future<void> updateById(String id) async {
    if (todoFormController.validate()) {
      todoFormController.setSubmitted(true);
      entity = entity.copyWith(
        status: TodoFormStatus.loading,
      );

      request<TodoUpdateSuccessInput>(
        TodoUpdateGatewayOutput(
            id: id,
            title: _titleController.value ?? '',
            description: _descriptionController.value ?? '',
            isCompleted: false),
        onSuccess: (success) {
          todoFormController.setSubmitted(false);
          return entity = entity.copyWith(
            id: success.id,
            title: success.title,
            description: success.description,
            isCompleted: success.isCompleted,
            createdAt: success.createdAt,
            updatedAt: success.updatedAt,
            status: TodoFormStatus.loaded,
          );
        },
        onFailure: (failure) => entity.copyWith(
          status: TodoFormStatus.failed,
        ),
      );
    }
  }

  @override
  void dispose() {
    todoFormController.dispose();
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
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}

class TodoFormInput extends SuccessInput {
  TodoFormInput({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final String createdAt;
  final String updatedAt;
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
      createdAt: input.createdAt,
      updatedAt: input.updatedAt,
    );
  }
}

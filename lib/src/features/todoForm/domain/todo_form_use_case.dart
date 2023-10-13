import 'package:clean_framework/clean_framework.dart';
import '../gateway/todo_create_gateway.dart';
import '../gateway/todo_update_gateway.dart';
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
      request<TodoCreateSuccessInput>(
        TodoCreateGatewayOutput(
            title: _titleController.value ?? '',
            description: _descriptionController.value ?? '',
            isCompleted: false),
        onSuccess: (success) {
          formController.setSubmitted(false);
          _titleController.setValue('');
          _descriptionController.setValue('');
          formController.reset();
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
    final formController = entity.formController;
    if (formController.validate()) {
      formController.setSubmitted(true);
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
          formController.setSubmitted(false);
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
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      formController: entity.formController,
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

import 'package:clean_framework/clean_framework.dart';

import '../gateway/todo_delete_gateway.dart';
import '../gateway/todo_read_gateway.dart';
import '../model/todo_model.dart';
import 'todo_list_entity.dart';
import 'todo_list_ui_output.dart';

class TodoListUseCase extends UseCase<TodoListEntity> {
  TodoListUseCase()
      : super(
          entity: const TodoListEntity(),
          transformers: [
            TodoListUIOutputTransformer(),
            RefreshedListInputTransformer(),
          ],
        );

  Future<void> fetchData({bool isRefresh = false}) async {
    if (!isRefresh) {
      entity = entity.copyWith(status: TodoListStatus.loading);
    }

    final input = await getInput(TodoReadGatewayOutput());
    switch (input) {
      case Success(:TodoReadSuccessInput input):
        final todos = input.todoIdentities.map(_resolveTodo);

        entity = entity.copyWith(
          todoList: todos.toList(growable: false),
          status: TodoListStatus.loaded,
          isRefresh: isRefresh,
        );
      case _:
        entity = entity.copyWith(
          status: TodoListStatus.failed,
          isRefresh: isRefresh,
        );
    }

    if (isRefresh) {
      entity = entity.copyWith(isRefresh: false, status: TodoListStatus.loaded);
    }
  }

  TodoModel _resolveTodo(TodoIdentity todo) {
    return TodoModel(
      id: todo.id,
      title: todo.title,
      description: todo.description,
      isCompleted: todo.isCompleted,
      createdAt: todo.createdAt,
      updatedAt: todo.updatedAt,
    );
  }

  Future<void> deleteById(String id) async {
    entity = entity.copyWith(
      status: TodoListStatus.loading,
    );

    request<TodoDeleteSuccessInput>(
      TodoDeleteGatewayOutput(id: id),
      onSuccess: (success) {
        final temp = entity.todoList.toList(growable: true);
        temp.removeWhere((element) => element.id == id);

        Future.delayed(const Duration(seconds: 3), () {
          entity = entity.copyWith(
            isDeleted: false,
          );
        });

        return entity = entity.copyWith(
          todoList: temp.toList(growable: false),
          status: TodoListStatus.loaded,
          isDeleted: true,
        );
      },
      onFailure: (failure) => entity.copyWith(
        status: TodoListStatus.failed,
      ),
    );
  }
}

class TodoListUIOutputTransformer
    extends OutputTransformer<TodoListEntity, TodoListUIOutput> {
  @override
  TodoListUIOutput transform(TodoListEntity entity) {
    return TodoListUIOutput(
      todoList: entity.todoList.toList(),
      status: entity.status,
      isRefresh: entity.isRefresh,
      isDeleted: entity.isDeleted,
    );
  }
}

class RefreshedListInput extends SuccessInput {
  RefreshedListInput({required this.todoDataList});

  final List<TodoModel> todoDataList;
}

class RefreshedListInputTransformer
    extends InputTransformer<TodoListEntity, RefreshedListInput> {
  @override
  TodoListEntity transform(TodoListEntity entity, RefreshedListInput input) {
    return entity.copyWith(todoList: input.todoDataList.toList());
  }
}

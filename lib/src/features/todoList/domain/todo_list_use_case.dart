import 'package:clean_framework/clean_framework.dart';

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

    List<TodoModel> temp = [];
    // for (var i = 0; i < 5; i++) {
    //   temp.add(
    //     TodoModel(
    //       id: '$i',
    //       title: 'title $i',
    //       description: 'description $i',
    //       isCompleted: false,
    //       createdAt: '',
    //       updatedAt: '',
    //     ),
    //   );
    // }
    Future.delayed(const Duration(seconds: 2), () {
      entity = entity.copyWith(
        todoList: temp.toList(growable: false),
        status: TodoListStatus.loaded,
        isRefresh: isRefresh,
      );
    });
    if (isRefresh) {
      entity = entity.copyWith(isRefresh: false, status: TodoListStatus.loaded);
    }
  }

  Future<void> deleteById(String id) async {
    entity = entity.copyWith(
      status: TodoListStatus.loading,
    );
    final temp = entity.todoList.toList(growable: true);
    temp.removeWhere((element) => element.id == id);

    Future.delayed(const Duration(seconds: 2), () {
      entity = entity.copyWith(
        todoList: temp.toList(growable: false),
        status: TodoListStatus.loaded,
        isDeleted: true,
      );
      Future.delayed(const Duration(seconds: 2), () {
        entity = entity.copyWith(
          isDeleted: false,
        );
      });
    });
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

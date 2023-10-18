import 'package:clean_framework/clean_framework.dart';
import '../model/todo_model.dart';

enum TodoListStatus { initial, loading, loaded, failed }

class TodoListEntity extends Entity {
  final List<TodoModel> todoList;
  final TodoListStatus status;

  final bool isRefresh;
  final bool isDeleted;

  const TodoListEntity({
    this.todoList = const [],
    this.status = TodoListStatus.initial,
    this.isRefresh = false,
    this.isDeleted = false,
  });

  @override
  TodoListEntity copyWith({
    List<TodoModel>? todoList,
    TodoListStatus? status,
    bool? isRefresh,
    bool? isDeleted,
  }) {
    return TodoListEntity(
      todoList: todoList ?? this.todoList,
      status: status ?? this.status,
      isRefresh: isRefresh ?? this.isRefresh,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  List<Object?> get props => [
        todoList,
        status,
        isRefresh,
        isDeleted,
      ];
}

import 'package:clean_framework/clean_framework.dart';

import '../../todoList/domain/todo_list_use_case.dart';
import '../domain/todo_list_entity.dart';

final todoListUseCaseProvider =
    UseCaseProvider<TodoListEntity, TodoListUseCase>(TodoListUseCase.new);

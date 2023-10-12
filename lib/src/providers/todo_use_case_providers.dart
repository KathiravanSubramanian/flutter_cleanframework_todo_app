import 'package:clean_framework/clean_framework.dart';

import '/src/features/splash/domain/splash_entity.dart';
import '/src/features/todoList/domain/todo_list_entity.dart';
import '/src/features/todoList/model/todo_model.dart';

import '../features/splash/domain/splash_use_case.dart';
import '../features/todoForm/providers/todo_form_providers.dart';
import '../features/todoList/domain/todo_list_use_case.dart';

final splashUseCaseProvider =
    UseCaseProvider.autoDispose<SplashEntity, SplashUseCase>(
  SplashUseCase.new,
);

final todoListAutoUseCaseProvider =
    UseCaseProvider.autoDispose<TodoListEntity, TodoListUseCase>(
  TodoListUseCase.new,
  (bridge) {
    bridge.connect(
      todoFormUseCaseProvider,
      (oldEntity, newEntity) {
        if (newEntity.id != '') {
          final tempList =
              // ignore: invalid_use_of_protected_member
              bridge.useCase.entity.todoList.toList(growable: true);
          final todo = TodoModel(
              id: newEntity.id,
              title: newEntity.title,
              description: newEntity.description,
              isCompleted: newEntity.isCompleted,
              createdAt: '',
              updatedAt: '');
          final isExist = tempList
              .where((element) => element.id == newEntity.id)
              .isNotEmpty;
          if (isExist) {
            tempList[tempList
                .indexWhere((element) => element.id == newEntity.id)] = todo;
          } else {
            tempList.add(todo);
          }

          bridge.useCase.setInput(
            RefreshedListInput(todoDataList: tempList),
          );
        }
      },
      selector: (entity) => entity,
    );
  },
);

import 'package:clean_framework/clean_framework.dart';

import '../domain/todo_form_entity.dart';
import '../domain/todo_form_use_case.dart';

final todoFormUseCaseProvider =
    UseCaseProvider<TodoFormEntity, TodoFormUseCase>(TodoFormUseCase.new);

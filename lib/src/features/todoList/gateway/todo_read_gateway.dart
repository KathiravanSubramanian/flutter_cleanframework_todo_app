import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_http/clean_framework_http.dart';

import '../model/todo_model.dart';

class TodoReadGateway extends Gateway<TodoReadGatewayOutput, TodoReadRequest,
    SuccessResponse, TodoReadSuccessInput> {
  @override
  TodoReadRequest buildRequest(TodoReadGatewayOutput output) {
    return TodoReadRequest();
  }

  @override
  FailureInput onFailure(FailureResponse failureResponse) {
    return FailureInput(message: failureResponse.message);
  }

  @override
  TodoReadSuccessInput onSuccess(JsonHttpSuccessResponse response) {
    final deserializer = Deserializer(response.data);
    return TodoReadSuccessInput(
      todoList: deserializer.getList('items', converter: TodoModel.fromJson),
    );
  }
}

class TodoReadGatewayOutput extends Output {
  @override
  List<Object?> get props => [];
}

class TodoReadSuccessInput extends SuccessInput {
  const TodoReadSuccessInput({required this.todoList});

  final List<TodoModel> todoList;
}

class TodoReadRequest extends GetHttpRequest {
  @override
  String get path => 'todos?page=1&limit=10';
}

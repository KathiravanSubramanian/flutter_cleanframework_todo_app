import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_http/clean_framework_http.dart';

import '../model/todo_model.dart';

class TodoDeleteGateway extends Gateway<TodoDeleteGatewayOutput,
    TodoDeleteRequest, SuccessResponse, TodoDeleteSuccessInput> {
  @override
  TodoDeleteRequest buildRequest(TodoDeleteGatewayOutput output) {
    return TodoDeleteRequest(id: output.id);
  }

  @override
  FailureInput onFailure(FailureResponse failureResponse) {
    return FailureInput(message: failureResponse.message);
  }

  @override
  TodoDeleteSuccessInput onSuccess(JsonHttpSuccessResponse response) {
    final deserializer = Deserializer(response.data);
    return TodoDeleteSuccessInput(
      todo: TodoModel.fromJson(deserializer.getMap('data')),
    );
  }
}

class TodoDeleteGatewayOutput extends Output {
  final String id;
  const TodoDeleteGatewayOutput({
    required this.id,
  });
  @override
  List<Object?> get props => [id];
}

class TodoDeleteSuccessInput extends SuccessInput {
  const TodoDeleteSuccessInput({required this.todo});

  final TodoModel todo;
}

class TodoDeleteRequest extends DeleteHttpRequest {
  final String id;
  const TodoDeleteRequest({
    required this.id,
  });

  @override
  String get path => 'todos/$id';
}

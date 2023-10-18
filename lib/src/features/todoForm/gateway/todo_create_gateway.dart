import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_http/clean_framework_http.dart';

class TodoCreateGateway extends Gateway<TodoCreateGatewayOutput,
    TodoCreateRequest, SuccessResponse, TodoCreateSuccessInput> {
  @override
  TodoCreateRequest buildRequest(TodoCreateGatewayOutput output) {
    return TodoCreateRequest(
      title: output.title,
      description: output.description,
      isCompleted: output.isCompleted,
    );
  }

  @override
  FailureInput onFailure(FailureResponse failureResponse) {
    return FailureInput(message: failureResponse.message);
  }

  @override
  TodoCreateSuccessInput onSuccess(JsonHttpSuccessResponse response) {
    final deserializer = Deserializer(response.data);
    final data = deserializer.getMap('data');
    return TodoCreateSuccessInput(
      id: data['_id'],
      title: data['title'],
      description: data['description'],
      isCompleted: data['is_completed'],
      createdAt: data['created_at'],
      updatedAt: data['updated_at'],
    );
  }
}

class TodoCreateGatewayOutput extends Output {
  final String title;
  final String description;
  final bool isCompleted;
  const TodoCreateGatewayOutput({
    required this.title,
    required this.description,
    required this.isCompleted,
  });
  @override
  List<Object?> get props => [title, description, isCompleted];
}

class TodoCreateSuccessInput extends SuccessInput {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final String createdAt;
  final String updatedAt;
  TodoCreateSuccessInput({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
  });
}

class TodoCreateRequest extends PostHttpRequest {
  final String title;
  final String description;
  final bool isCompleted;

  const TodoCreateRequest({
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  @override
  String get path => 'todos';

  @override
  Map<String, dynamic> get data =>
      {'title': title, 'description': description, 'is_completed': isCompleted};
}

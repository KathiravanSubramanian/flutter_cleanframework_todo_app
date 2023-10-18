import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_http/clean_framework_http.dart';

class TodoUpdateGateway extends Gateway<TodoUpdateGatewayOutput,
    TodoUpdateRequest, SuccessResponse, TodoUpdateSuccessInput> {
  @override
  TodoUpdateRequest buildRequest(TodoUpdateGatewayOutput output) {
    return TodoUpdateRequest(
        id: output.id,
        title: output.title,
        description: output.description,
        isCompleted: output.isCompleted);
  }

  @override
  FailureInput onFailure(FailureResponse failureResponse) {
    return FailureInput(message: failureResponse.message);
  }

  @override
  TodoUpdateSuccessInput onSuccess(JsonHttpSuccessResponse response) {
    final deserializer = Deserializer(response.data);
    final data = deserializer.getMap('data');
    return TodoUpdateSuccessInput(
      id: data['_id'],
      title: data['title'],
      description: data['description'],
      isCompleted: data['is_completed'],
      createdAt: data['created_at'],
      updatedAt: data['updated_at'],
    );
  }
}

class TodoUpdateGatewayOutput extends Output {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  const TodoUpdateGatewayOutput({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
  });
  @override
  List<Object?> get props => [id, title, description, isCompleted];
}

class TodoUpdateSuccessInput extends SuccessInput {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final String createdAt;
  final String updatedAt;
  TodoUpdateSuccessInput({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
  });
}

class TodoUpdateRequest extends PutHttpRequest {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  const TodoUpdateRequest({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  @override
  String get path => 'todos/$id';

  @override
  Map<String, dynamic> get data =>
      {'title': title, 'description': description, 'is_completed': isCompleted};
}

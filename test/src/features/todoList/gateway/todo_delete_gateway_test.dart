import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_http/clean_framework_http.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoList/gateway/todo_delete_gateway.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TodoDeleteGateway tests |', () {
    test('verify request', () {
      final gateway = TodoDeleteGateway();
      const gatewayOutput = TodoDeleteGatewayOutput(id: '45');

      final request = gateway.buildRequest(gatewayOutput);

      expect(request.path, equals('todos/${gatewayOutput.id}'));
      expect(gatewayOutput, const TodoDeleteGatewayOutput(id: '45'));
    });

    test('success', () async {
      final gateway = TodoDeleteGateway()
        ..feedResponse(
          (request) async => const Either.right(
            JsonHttpSuccessResponse(
              {
                'data': {
                  '_id': '45',
                  'title': 'welcome',
                  'description': 'welcome 2',
                  'is_completed': false,
                  'created_at': '',
                  'updated_at': ''
                }
              },
              200,
            ),
          ),
        );

      final input =
          await gateway.buildInput(const TodoDeleteGatewayOutput(id: '45'));

      expect(input.isRight, isTrue);
      final todo = input.right.todo;
      expect(todo.id, equals('45'));
      expect(todo.title, equals('welcome'));
      expect(todo.description, equals('welcome 2'));
      expect(todo.isCompleted, equals(false));
    });

    test('failure', () async {
      final gateway = TodoDeleteGateway()
        ..feedResponse(
          (request) async => Either.left(
            UnknownFailureResponse('No Internet'),
          ),
        );

      final input =
          await gateway.buildInput(const TodoDeleteGatewayOutput(id: '45'));

      expect(input.isLeft, isTrue);

      expect(input.left.message, equals('No Internet'));
    });
  });
}

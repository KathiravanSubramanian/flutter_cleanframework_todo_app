import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_http/clean_framework_http.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoList/gateway/todo_read_gateway.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TodoReadGateway tests |', () {
    test('verify request', () {
      final gateway = TodoReadGateway();
      final gatewayOutput = TodoReadGatewayOutput();

      final request = gateway.buildRequest(gatewayOutput);

      expect(request.path, equals('todos?page=1&limit=10'));
      expect(gatewayOutput, TodoReadGatewayOutput());
    });

    test('success', () async {
      final gateway = TodoReadGateway()
        ..feedResponse(
          (request) async => const Either.right(
            JsonHttpSuccessResponse(
              {
                'items': [
                  {
                    '_id': '45',
                    'title': 'welcome',
                    'description': 'welcome 2',
                    'is_completed': false,
                    'created_at': '',
                    'updated_at': ''
                  }
                ],
              },
              200,
            ),
          ),
        );

      final input = await gateway.buildInput(TodoReadGatewayOutput());

      expect(input.isRight, isTrue);
      final todoList = input.right.todoIdentities;
      expect(todoList.first.id, equals('45'));
      expect(todoList.first.title, equals('welcome'));
      expect(todoList.first.description, equals('welcome 2'));
      expect(todoList.first.isCompleted, equals(false));
    });

    test('failure', () async {
      final gateway = TodoReadGateway()
        ..feedResponse(
          (request) async => Either.left(
            UnknownFailureResponse('No Internet'),
          ),
        );

      final input = await gateway.buildInput(TodoReadGatewayOutput());

      expect(input.isLeft, isTrue);

      expect(input.left.message, equals('No Internet'));
    });
  });
}

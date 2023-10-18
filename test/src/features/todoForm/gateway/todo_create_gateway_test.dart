import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_http/clean_framework_http.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoForm/gateway/todo_create_gateway.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TodoCreateGateway tests |', () {
    test('verify request', () {
      final gateway = TodoCreateGateway();
      const gatewayOutput = TodoCreateGatewayOutput(
          title: 'welcome',
          description: 'welcome description',
          isCompleted: false);

      final request = gateway.buildRequest(gatewayOutput);

      expect(request.path, equals('todos'));
      expect(
          request.data,
          equals({
            'title': gatewayOutput.title,
            'description': gatewayOutput.description,
            'is_completed': gatewayOutput.isCompleted
          }));

      expect(
          gatewayOutput,
          const TodoCreateGatewayOutput(
              title: 'welcome',
              description: 'welcome description',
              isCompleted: false));
    });

    test('success', () async {
      final gateway = TodoCreateGateway()
        ..feedResponse(
          (request) async => const Either.right(
            JsonHttpSuccessResponse(
              {
                'data': {
                  '_id': '45',
                  'title': 'welcome',
                  'description': 'welcome description',
                  'is_completed': false,
                  'created_at': '',
                  'updated_at': ''
                }
              },
              200,
            ),
          ),
        );

      final input = await gateway.buildInput(const TodoCreateGatewayOutput(
          title: 'welcome',
          description: 'welcome description',
          isCompleted: false));

      expect(input.isRight, isTrue);
      expect(input.right.id, equals('45'));
      expect(input.right.title, equals('welcome'));
      expect(input.right.description, equals('welcome description'));
      expect(input.right.isCompleted, equals(false));
    });

    test('failure', () async {
      final gateway = TodoCreateGateway()
        ..feedResponse(
          (request) async => Either.left(
            UnknownFailureResponse('No Internet'),
          ),
        );

      final input = await gateway.buildInput(const TodoCreateGatewayOutput(
          title: 'welcome',
          description: 'welcome description',
          isCompleted: false));

      expect(input.isLeft, isTrue);

      expect(input.left.message, equals('No Internet'));
    });
  });
}

import 'package:clean_framework/clean_framework.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dummy_dio;

import 'package:flutter_cleanframework_todo_app/src/features/todoList/gateway/todo_read_gateway.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoList/providers/todo_list_external_interface_providers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

final restClientProvider = DependencyProvider(
  (_) => Dio(BaseOptions(baseUrl: 'https://api.nstack.in/v1/')),
);

void main() {
  group('TodoExternalInterface tests |', () {
    test('get request success', () async {
      final container = ProviderContainer(
        overrides: [
          restClientProvider.overrideWith(DioMock()),
        ],
      );
      final dio = restClientProvider.read(container);
      final interface = readExternalInterfaceProvider.read(container);

      when(
        () => dio.get<dynamic>(
          'items',
        ),
      ).thenAnswer(
        (_) async => dummy_dio.Response(
          data: {
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
          requestOptions: RequestOptions(path: 'todos?page=1&limit=10'),
        ),
      );

      final result = await interface.request(TodoReadRequest());

      expect(result.isRight, isTrue);
      expect(result.right.data, isA<Map<String, dynamic>>());
    });
  });
}

class DioMock extends Mock implements Dio {}

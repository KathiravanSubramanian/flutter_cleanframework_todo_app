import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_http/clean_framework_http.dart';
import 'package:flutter_cleanframework_todo_app/src/external_interface/api_external_interface.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoList/gateway/todo_delete_gateway.dart';

class TodoDeleteExternalInterfaceFake extends ApiExternalInterface {
  @override
  void handleRequest() {
    on<DeleteHttpRequest>(
      (request, send) async {
        if (request is TodoDeleteRequest) {
          send(
            const JsonHttpSuccessResponse(
              {
                '_id': '45',
                'title': 'welcome',
                'description': 'welcome 2',
                'is_completed': false,
                'created_at': '',
                'updated_at': ''
              },
              200,
            ),
          );
        }
      },
    );
  }

  @override
  FailureResponse onError(Object error) {
    throw UnimplementedError();
  }
}

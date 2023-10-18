import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_http/clean_framework_http.dart';
import 'package:flutter_cleanframework_todo_app/src/external_interface/api_external_interface.dart';
import 'package:flutter_cleanframework_todo_app/src/features/todoForm/gateway/todo_update_gateway.dart';

class TodoUpdateExternalInterfaceFake extends ApiExternalInterface {
  @override
  void handleRequest() {
    on<PutHttpRequest>(
      (request, send) async {
        if (request is TodoUpdateRequest) {
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

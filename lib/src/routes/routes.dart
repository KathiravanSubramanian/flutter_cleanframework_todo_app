import 'package:clean_framework_router/clean_framework_router.dart';

export 'project_router.dart';

enum Routes with RoutesMixin {
  splash('/'),
  todoList('todoList'),
  todoForm('todoForm');

  const Routes(this.path);
  @override
  final String path;
}

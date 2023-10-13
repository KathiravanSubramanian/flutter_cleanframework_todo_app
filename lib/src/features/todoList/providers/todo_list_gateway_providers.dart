import 'package:clean_framework/clean_framework.dart';

import '../gateway/todo_delete_gateway.dart';
import '../gateway/todo_read_gateway.dart';
import 'todo_list_use_case_providers.dart';

final todoReadGatewayProvider = GatewayProvider(
  TodoReadGateway.new,
  useCases: [todoListUseCaseProvider],
);

final todoDeleteGatewayProvider = GatewayProvider(
  TodoDeleteGateway.new,
  useCases: [todoListUseCaseProvider],
);

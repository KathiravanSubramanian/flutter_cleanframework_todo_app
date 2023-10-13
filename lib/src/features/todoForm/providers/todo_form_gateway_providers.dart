import 'package:clean_framework/clean_framework.dart';

import '../gateway/todo_create_gateway.dart';
import '../gateway/todo_update_gateway.dart';
import 'todo_form_use_case_providers.dart';

final todoCreateGatewayProvider = GatewayProvider(
  TodoCreateGateway.new,
  useCases: [todoFormUseCaseProvider],
);

final todoUpdateGatewayProvider = GatewayProvider(
  TodoUpdateGateway.new,
  useCases: [todoFormUseCaseProvider],
);

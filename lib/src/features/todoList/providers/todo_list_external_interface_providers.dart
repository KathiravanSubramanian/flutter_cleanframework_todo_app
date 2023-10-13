import 'package:clean_framework/clean_framework.dart';

import '../../../external_interface/api_external_interface.dart';
import 'todo_list_gateway_providers.dart';

final readExternalInterfaceProvider = ExternalInterfaceProvider(
  ApiExternalInterface.new,
  gateways: [
    todoReadGatewayProvider,
  ],
);

final deleteExternalInterfaceProvider = ExternalInterfaceProvider(
  ApiExternalInterface.new,
  gateways: [
    todoDeleteGatewayProvider,
  ],
);

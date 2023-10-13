import 'package:clean_framework/clean_framework.dart';

import '../../../external_interface/api_external_interface.dart';
import 'todo_form_gateway_providers.dart';

final createExternalInterfaceProvider = ExternalInterfaceProvider(
  ApiExternalInterface.new,
  gateways: [
    todoCreateGatewayProvider,
  ],
);

final updateExternalInterfaceProvider = ExternalInterfaceProvider(
  ApiExternalInterface.new,
  gateways: [
    todoUpdateGatewayProvider,
  ],
);

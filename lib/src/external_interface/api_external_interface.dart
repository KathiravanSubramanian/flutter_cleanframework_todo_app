import 'package:clean_framework_http/clean_framework_http.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '/src/core/core.dart';

class ApiExternalInterface extends HttpExternalInterface {
  ApiExternalInterface()
      : super(delegate: _TodoHttpExternalInterfaceDelegate());
}

class _TodoHttpExternalInterfaceDelegate extends HttpExternalInterfaceDelegate {
  _TodoHttpExternalInterfaceDelegate();

  @override
  Future<HttpOptions> buildOptions() async {
    return const HttpOptions(
      baseUrl: ConstantProvider.baseUrl,
      responseType: HttpResponseType.json,
    );
  }

  @override
  Future<Dio> buildDio(BaseOptions options) async {
    final dio = await super.buildDio(options);
    return dio
      ..interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          compact: false,
        ),
      );
  }
}

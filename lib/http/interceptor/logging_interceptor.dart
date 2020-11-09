import 'package:flutter/cupertino.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    debugPrint('Request to: ${methodToString(data.method)} ${data.url}');
    debugPrint('headers: ${data.headers}');
    debugPrint('body: ${data.body}');
    debugPrint('---------------------');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    debugPrint(
        'Response from: ${methodToString(data.method)} ${data.url} ${data.statusCode} ');
    debugPrint('headers: ${data.headers}');
    debugPrint('body: ${data.body}');
    debugPrint('---------------------');
    return data;
  }
}

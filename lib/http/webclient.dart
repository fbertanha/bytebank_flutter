import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print(data);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print(data);
    return data;
  }
}

void findAll() async {
  final Client client = HttpClientWithInterceptor.build(interceptors: [
    LoggingInterceptor(),
  ]);

  final Response response =
      await client.get('http://192.168.0.100:8080/transactions');
}

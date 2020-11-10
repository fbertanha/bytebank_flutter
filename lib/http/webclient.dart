import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'interceptor/logging_interceptor.dart';

const String baseUrl = 'http://192.168.0.100:8080';
const String baseUrlTransactions = '$baseUrl/transactions';

final Client client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()], requestTimeout: Duration(seconds: 5));

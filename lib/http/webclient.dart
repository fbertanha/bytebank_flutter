import 'dart:convert';

import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
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

Future<List<Transaction>> findAll() async {
  final Client client = HttpClientWithInterceptor.build(interceptors: [
    LoggingInterceptor(),
  ]);

  final Response response =
      await client.get('http://192.168.0.100:8080/transactions');

  final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<Transaction> transactions = List();

  decodedJson.forEach((item) {
    final Transaction transaction = Transaction(
        item['value'],
        Contact(
          0,
          item['contact']['name'],
          item['contact']['accountNumber'],
        ));

    transactions.add(transaction);
  });
  // print(decodedJson);
  // print(transactions);

  return transactions;
}

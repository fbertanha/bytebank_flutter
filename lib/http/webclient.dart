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

const String baseUrl = 'http://192.168.0.100:8080';
const String baseUrlTransactions = '$baseUrl/transactions';

Future<List<Transaction>> findAll() async {
  final Client client = HttpClientWithInterceptor.build(interceptors: [
    LoggingInterceptor(),
  ]);

  final Response response =
      await client.get(baseUrlTransactions).timeout(Duration(seconds: 5));

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

Future<Transaction> save(Transaction transaction) async {
  final Client client = HttpClientWithInterceptor.build(interceptors: [
    LoggingInterceptor(),
  ]);

  final Map<String, dynamic> transactionMap = {
    'value': transaction.value,
    'contact': {
      'name': transaction.contact.name,
      'accountNumber': transaction.contact.accountNumber
    }
  };
  final String transactionJson = jsonEncode(transactionMap);

  final Response response = await client.post(
    baseUrlTransactions,
    headers: {'Content-type': 'application/json', 'password': '1000'},
    body: transactionJson,
  );

  Map<String, dynamic> json = jsonDecode(response.body);

  return Transaction(
      json['value'],
      Contact(
        0,
        json['contact']['name'],
        json['contact']['accountNumber'],
      ));
}

import 'dart:async';
import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  static final Map<int, String> _statusCodeResponses = {
    400: 'there was an error submitting the transaction',
    401: 'authentication failed',
    409: 'transaction already exists'
  };

  Future<List<Transaction>> findAll() async {
    final Response response = await client.get(baseUrlTransactions);

    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map<Transaction>((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    await Future.delayed(Duration(seconds: 10));
    final Response response = await client.post(
      baseUrlTransactions,
      headers: {'Content-type': 'application/json', 'password': password},
      body: transactionJson,
    );

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }

    throw HttpException(_getMessage(response.statusCode));
  }

  String _getMessage(int statusCode) {
    if (_statusCodeResponses.containsKey(statusCode)) {
      return _statusCodeResponses[statusCode];
    }
    return 'unknown error';
  }
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}

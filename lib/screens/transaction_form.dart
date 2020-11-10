import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/http/clients/transaction_webclient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Transfer'),
                    onPressed: () => _doTransfer(context),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _doTransfer(BuildContext context) async {
    final double value = double.tryParse(_valueController.text);
    final transactionCreated = Transaction(value, widget.contact);

    showDialog(
        context: context,
        builder: (dialogContext) {
          return TransactionAuthDialog(
            onConfirm: (password) =>
                _save(transactionCreated, password, context),
          );
        });
  }

  Future _save(Transaction transactionCreated, String password,
      BuildContext context) async {
    final Transaction newTransaction =
        await _webClient.save(transactionCreated, password).catchError((error) {
      _showErrorOnSaveTransaction(context, error);
    }, test: (e) => e is Exception);

    await _showSuccessOnTransactionSaved(newTransaction, context);
  }

  void _showErrorOnSaveTransaction(BuildContext context, error) {
    showDialog(
        context: context,
        builder: (dialogContext) {
          return FailureDialog(error.message);
        });
  }

  Future _showSuccessOnTransactionSaved(
      Transaction newTransaction, BuildContext context) async {
    if (newTransaction != null) {
      await showDialog(
          context: context,
          builder: (dialogContext) {
            return SuccessDialog('successful transaction');
          });
      Navigator.pop(context);
    }
  }
}

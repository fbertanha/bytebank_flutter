import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatefulWidget {
  final Function(String password) onConfirm;

  TransactionAuthDialog({@required this.onConfirm});

  @override
  _TransactionAuthDialogState createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Authenticate',
        textAlign: TextAlign.center,
      ),
      content: TextField(
        controller: _passwordController,
        keyboardType: TextInputType.number,
        obscureText: true,
        maxLength: 4,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 64, letterSpacing: 16),
        decoration: InputDecoration(border: OutlineInputBorder()),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'CANCEL',
            style: TextStyle(fontSize: 16),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text('CONFIRM'),
          onPressed: () {
            widget.onConfirm(_passwordController.text);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

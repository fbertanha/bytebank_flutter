import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Authenticate',
        textAlign: TextAlign.center,
      ),
      content: TextField(
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
          onPressed: () => print('canceled'),
        ),
        FlatButton(
          child: Text('CONFIRM'),
          onPressed: () => print('hi'),
        ),
      ],
    );
  }
}

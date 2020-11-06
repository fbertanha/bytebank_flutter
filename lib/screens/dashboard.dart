import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/transactions_list.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset('images/bytebank_logo.png'),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  _FeatureItem(
                    name: 'Transfer',
                    icon: Icons.monetization_on,
                    onTap: () => _showContactList(context),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  _FeatureItem(
                    name: 'Transaction feed',
                    icon: Icons.description,
                    onTap: () {
                      _showTransactionFeed(context);
                    },
                  ),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showContactList(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ContactsList(),
    ));
  }

  void _showTransactionFeed(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TransactionsList(),
    ));
  }
}

class _FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onTap;

  _FeatureItem({this.name, this.icon, @required this.onTap})
      : assert(onTap != null);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      child: InkWell(
        onTap: this.onTap,
        child: Container(
          padding: EdgeInsets.all(8),
          height: 100,
          width: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                this.icon,
                color: Colors.white,
                size: 32,
              ),
              Text(
                this.name,
                style: TextStyle(color: Colors.white, fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:bytebank/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() {
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'bytebank.db');
    return openDatabase(path, onCreate: (db, version) {
      db.execute('CREATE TABLE contacts('
          'id INTEGER PRIMARY KEY, '
          'name TEXT, '
          'account_number INTEGER'
          ')');
    }, version: 1, onDowngrade: onDatabaseDowngradeDelete);
  });
}

Future<int> save(Contact contact) {
  return createDatabase().then((db) {
    final Map<String, dynamic> contactMap = Map();

    contactMap['name'] = contact.name;
    contactMap['account_number'] = contact.accountNumber;

    return db.insert('contacts', contactMap);
  });
}

Future<List<Contact>> findAllContacts() {
  return createDatabase().then((db) {
    return db.query('contacts').then((maps) {
      final List<Contact> contacts = List();

      maps.forEach((item) {
        contacts.add(new Contact(
          item['id'],
          item['name'],
          item['account_number'],
        ));
      });

      return contacts;
    });
  });
}

import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'constant.dart';

class MongoDatabase {
  static late Db db;
  static late DbCollection collection;

  static Future<void> connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
    log(db.toString());
    var status = await db.serverStatus();
    print(status);
    collection = db.collection(COLLECTION_NAME);
  }

  static Future<bool> isEmailExists(String mail) async {
    var query = where.eq('mail', mail);
    var user = await collection.findOne(query);
    return user != null;
  }

  static Future<void> insertData(String name, String mail, String password) async {
    var query = where.eq('mail', mail).eq('password', password);
    var user = await collection.findOne(query);

    if (user == null) {
      await collection.insertOne({
        "name": name,
        "mail": mail,
        "password": password,
        "addresses": [],
      });
    }
  }
  static Future<bool> verifyUser(String mail, String password) async {
    var query = where.eq('mail', mail).eq('password', password);
    var user = await collection.findOne(query);
    return user != null;
  }

  static Future<String?> findUserIdByEmail(String email) async {
    var query = where.eq('mail', email);
    var user = await collection.findOne(query);

    if (user != null) {
      return user['_id'].toString();
    }

    return null;
  }

  static Future<String?> findNameByMail(String mail) async {
    var query = where.eq('mail', mail);
    var user = await collection.findOne(query);
    if (user != null) {
      return user['name'];
    }
    return null;
  }

  static Future<void> insertAddressByEmail(String mail, String address) async {
    var query = where.eq('mail', mail);
    var user = await collection.findOne(query);

    if (user != null) {
      await collection.update(
        query,
        modify.push('addresses', address),
      );
    }
  }

  static Future<List<String>> getAddressesByEmail(String mail) async {
    var query = where.eq('mail', mail);
    var user = await collection.findOne(query);

    if (user != null) {
      var addresses = user['addresses'] as List<dynamic>;
      return addresses.map((address) => address.toString()).toList();
    } else {
      return [];
    }
  }

  static Future<void> updateEmail(String oldMail, String newMail) async {
    var query = where.eq('mail', oldMail);
    var user = await collection.findOne(query);

    if (user != null) {
      await collection.update(
        query,
        modify.set('mail', newMail),
      );
    }
  }
  static Future<void> updateNameByEmail(String email, String newName) async {
    var query = where.eq('mail', email);
    var user = await collection.findOne(query);

    if (user != null) {
      await collection.update(
        query,
        modify.set('name', newName),
      );
    }
  }
  static Future<void> updatePasswordByEmail(String email, String newPassword) async {
    if (newPassword.isEmpty) {
      print('Yeni şifre boş olamaz.');
      return;
    }
    var query = where.eq('mail', email);
    var user = await collection.findOne(query);
    if (user != null) {
      try {
        await collection.update(
          query,
          modify.set('password', newPassword),
        );
        print('Kullanıcı şifresi güncellendi.');
      } catch (e) {
        print('Hata oluştu: $e');
      }
    } else {
      print('Kullanıcı bulunamadı.');
    }
  }

  static Future<void> deleteAddressByEmail(String email, String address) async {
    var query = where.eq('mail', email);
    var user = await collection.findOne(query);

    if (user != null) {
      await collection.update(
        query,
        modify.pull('addresses', address),
      );
    }
  }
  static Future<void> updateAddressByEmail(String email, String newAddress) async {
    var query = where.eq('mail', email);
    var user = await collection.findOne(query);

    if (user != null) {
      var addresses = user['addresses'] as List<dynamic>;
      var index = addresses.indexOf(newAddress);
      if (index != -1) {
        addresses[index] = newAddress;
        await collection.update(
          query,
          modify.set('addresses', addresses),
        );
      }
    }
  }


}

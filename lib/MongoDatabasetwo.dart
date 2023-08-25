import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'constant.dart';

class MongoDatabasetwo {
  static late Db db;
  static late DbCollection collection;

  static Future<void> connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
    log(db.toString());
    var status = await db.serverStatus();
    print(status);
    collection = db.collection(COLLECTION_NAME_TW0);
  }

  static Future<List<String>> getRestaurantNames() async {
    List<String> restaurantNames = [];
    await for (var item in collection.find()) {
      restaurantNames.add(item['restoran_adi'] as String);
    }
    return restaurantNames;
  }

  static Future<List<String>> getRestaurantUrunler(String restaurantName) async {
    List<String> urunler = [];
    try {
      Db db = await Db.create(MONGO_URL);
      await db.open();
      DbCollection restoranlarCollection = db.collection('restoranlar');
      var restoran = await restoranlarCollection.findOne(
        where.eq('restoran_adi', restaurantName),
      );
      if (restoran != null && restoran['restoran_urunler'] is List) {
        urunler = List<String>.from(restoran['restoran_urunler']);
      }
      db.close();
    } catch (e) {
      print("Hata oluştu: $e");
    }
    return urunler;}
}

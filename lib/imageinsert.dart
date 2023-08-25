import 'package:mongo_dart/mongo_dart.dart';
import 'dart:io';

void imageinsert() async {
  final db = Db('mongodb+srv://test:123@cluster0.shdhj6r.mongodb.net/project?retryWrites=true&w=majority');
  await db.open();

  var gridFs = GridFS(db);

  // Projedeki resimleri içeren klasör yolunu belirtin
  var imagesDirectory = Directory('images');

  // Klasördeki tüm dosyaları alın
  var imageFiles = imagesDirectory.listSync();

  // Tüm resimleri MongoDB'ye yükleyin
  for (var imageFile in imageFiles) {
    if (imageFile is File) {
      var imageStream = imageFile.openRead();
      var fileName = imageFile.path.split('/').last;

      var gridIn = await gridFs.createFile(imageStream, fileName);
      await gridIn.save();
    }
  }

  await db.close();
}
import 'package:flutter/material.dart';
import 'package:yeniproje/sepetim.dart';
import 'MongoDatabasetwo.dart';

class Detayrestorant extends StatefulWidget {
 final String restoran_adi;

 Detayrestorant({required this.restoran_adi});

  @override
  State<Detayrestorant> createState() => _DetayrestorantState();
}

class _DetayrestorantState extends State<Detayrestorant> {
  List<String> urunler = [];
  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    _getUrunler();
  }
  @override
  void dispose() {
    _isMounted = false; // Widget ağacında artık aktif olmadığımızı belirtelim.
    super.dispose();
  }

  Future<void> _getUrunler() async {
    try {
      List<String> urunler = await MongoDatabasetwo.getRestaurantUrunler(widget.restoran_adi);
      if (_isMounted) {
        setState(() {
          this.urunler = urunler;
        });
      }
    } catch (e) {
      print("Hata oluştu: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // urunler listesini kontrol et
    if (urunler.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: Text(widget.restoran_adi),
        ),
        body: Center(
          child: Text('Ürünler yükleniyor...'),
        ),
      );
    } else {
      // urunler listesi doluysa ListView.builder kullanarak ürünleri göster
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: Text(widget.restoran_adi),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: urunler.length,
            itemBuilder: (BuildContext context, int index) {
              String urunAdiFiyat = urunler[index];
              var splittedUrun = urunAdiFiyat.split(' - ');
              String urunAdi = splittedUrun[0].trim();
              String fiyat = splittedUrun[1].trim();
              return GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder:(context)=>sepetim()));
                },
                child: ListTile(
                  title: Text(urunAdi),
                  subtitle: Text('Fiyat: $fiyat'),
                ),
              );
            },
          ),
        ),
      );
    }
  }
}
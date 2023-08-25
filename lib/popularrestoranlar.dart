import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeniproje/Detayrestorant.dart';
import 'MongoDatabasetwo.dart';

class popularrestoranlar extends StatefulWidget {
  const popularrestoranlar({Key? key}) : super(key: key);

  @override
  State<popularrestoranlar> createState() => _popularrestoranlarState();
}

class _popularrestoranlarState extends State<popularrestoranlar> {
  List imgList = [
    Image.asset('images/ascioglu.png'),
    Image.asset('images/burgerking.png'),
    Image.asset('images/cigkofte.png'),
    Image.asset('images/korfez.png'),
    Image.asset('images/katik.png'),
    Image.asset('images/komagene.png'),
    Image.asset('images/mcdonalds.png'),
    Image.asset('images/baklava.png'),
    Image.asset('images/waffle.png'),
  ];

  List<String> restorantlar = [];

  @override
  void initState() {
    super.initState();
    MongoDatabasetwo.connect().then((_) {
      MongoDatabasetwo.getRestaurantNames().then((names) {
        setState(() {
          restorantlar = names;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var ekranbilgisi = MediaQuery.of(context);
    final double ekranyukseklik = ekranbilgisi.size.height;
    final double ekrangenislik = ekranbilgisi.size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 15),
                  child: Text(
                    "Popüler restoranlar",
                    style: GoogleFonts.aBeeZee(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: ekranyukseklik / 40,
                      color: Colors.black,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(1.5, 1.5),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemCount: imgList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap:(){print("tıklandı");
                 switch(index) {
                   case 0 :Navigator.push(context, MaterialPageRoute(builder: (context) => Detayrestorant(restoran_adi:"Aşçıoğlu Hatay Döner",),),);
                   case 1: Navigator.push(context, MaterialPageRoute(builder: (context) => Detayrestorant(restoran_adi: "Burger King",),),);
                   case 2: Navigator.push(context, MaterialPageRoute(builder: (context) => Detayrestorant(restoran_adi: "Hasan Aybak Çiğköfte",),),);
                   case 3: Navigator.push(context, MaterialPageRoute(builder: (context) => Detayrestorant(restoran_adi: "Körfez Döner" ,),),);
                   case 4: Navigator.push(context, MaterialPageRoute(builder: (context) => Detayrestorant(restoran_adi: "Katık Döner",),),);
                   case 5: Navigator.push(context, MaterialPageRoute(builder: (context) => Detayrestorant(restoran_adi: "Komagene",),),);
                   case 6: Navigator.push(context, MaterialPageRoute(builder: (context) => Detayrestorant(restoran_adi: "Develiler Baklava",),),);
                   case 7: Navigator.push(context, MaterialPageRoute(builder: (context) => Detayrestorant(restoran_adi: "Waffle Lina",),),);
                 }
                  },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                          child: Container(
                            width: ekrangenislik / 1.5,
                            height: ekranyukseklik / 5,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imgList[index % imgList.length].image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 120),
                                    child: Text(
                                      restorantlar[index % restorantlar.length],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 15);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

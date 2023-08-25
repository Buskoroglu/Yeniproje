import 'package:flutter/material.dart';
import 'package:yeniproje/adreslerim.dart';
import 'package:yeniproje/eskisiparisler.dart';
import 'package:yeniproje/hesabim.dart';
import 'package:yeniproje/kategoriler.dart';
import 'package:yeniproje/kuponlar.dart';
import 'package:yeniproje/popularrestoranlar.dart';
import 'package:yeniproje/sepetim.dart';

import 'MongoDatabase.dart';

class anasayfa extends StatefulWidget {

  final String usermail;
  final String password;


  anasayfa({required this.usermail,required this.password});

  @override
  State<anasayfa> createState() => _anasayfaState();
}
class _anasayfaState extends State<anasayfa> {
  @override
  String? isim;
  @override
  void initState() {
    super.initState();
    getNameFromDatabase(); // Kullanıcının adını veritabanından çekmek için fonksiyonu çağırın.
  }

  void getNameFromDatabase() async {
    String? userName = await MongoDatabase.findNameByMail(widget.usermail);
    setState(() {
      isim = userName;
    });
  }



  @override
  Widget build(BuildContext context) {
    var ekranbilgisi =MediaQuery.of(context);
    final double ekranyukseklik = ekranbilgisi.size.height;
    final double ekrangenislik = ekranbilgisi.size.width;
    int _selectedIndex = 1;

    List<Widget> _pages = [
      eskisiparisler(),
      anasayfa(usermail: "",password: "",),
      sepetim(),
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => _pages[index]),
      );
    }
    List kupon =[
      Image.asset("images/kupon5.png"),
      Image.asset("images/kupon1.png"),
      Image.asset("images/kupon3.png"),
      Image.asset("images/kupon4.png"),
      Image.asset("images/kupon.png"),
    ];
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

    final List<String> restorantlar = [
      'AŞÇIOĞLU HATAY DÖNER',
      'BURGER KİNG',
      'HASAN AYBAK ÇİĞKÖFTE',
      'KÖRFEZ DÖNER',
      'KATIK DÖNER',
      'KOMAGENE',
      "MC'DONALDS",
      "DEVELİLER BAKLAVA",
      "WAFFLE LİNA"
    ];


    final List<String> items = [
      'Döner',
      'Tantuni',
      'Kebap',
      'Çiğköfte',
      'Köfte',
      'Kumpir',
      'Waffle',
      'Baklava',
      'Pasta',
      'Tost/Sandviç',
    ];



    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: TextField(
            decoration: InputDecoration(
              hintText: "restoran veya yemek ara ..",
            ),

          ),
        ),
        backgroundColor: Colors.amber,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {

            },
          ),
        ],
      ),

      bottomNavigationBar:BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.import_contacts_rounded),
            label: 'siparişlerim',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'keşfet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'sepetim',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // onTap özelliğine _onItemTapped fonksiyonunu atama
      ),

      drawer: Drawer(
        backgroundColor: Colors.blueGrey.shade50,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
              child: Center(
                child: Expanded(
                  child: Text(
                    'Hoşgeldiniz ${isim} !',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Hesabım'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => hesabim(mail:widget.usermail,password:widget.password ,)),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.label_important_outlined),
              title: Text('Kuponlarım'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => kuponlar()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Adreslerim'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => adreslerim(mail:widget.usermail,)),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                height: ekranyukseklik / 3.5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, top: 10),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: kupon.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: kupon[index].image, // Resmi buradan alın
                                fit: BoxFit.cover,
                              ),
                            ),
                            width: ekrangenislik / 0.9,
                            height: 50,
                          ),
                          onTap: () {
                            // Resme tıklama işlemleri burada gerçekleştirilebilir (isteğe bağlı)
                          },
                        ),
                      );
                    },
                    padding: EdgeInsets.only(right: 3),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top:10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text("Mutfaklar",style: TextStyle(color: Colors.black87)),
                    ),

                    TextButton(onPressed:(){
                      Navigator.push(context,MaterialPageRoute(builder: (context) => kategoriler()));
                    }, child:Text("Tümünü gör"),style: TextButton.styleFrom(
                      textStyle: TextStyle(decoration: TextDecoration.underline),),),
                  ],
                ),
              ),
              Container(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: GestureDetector(
                          child: Container(
                            width: 50,
                            height: 50,
                            color: Colors.orange,
                            child: Center(
                              child: Text(
                                items[index],
                                style: TextStyle(color: Colors.white, fontSize: 10.0),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(width: 8);
                    },
                  ),
                ),
              ),
              SizedBox(height: ekranyukseklik/35,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text("Popüler restoranlar",style: TextStyle()),
                  ),
                  TextButton(onPressed:(){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => popularrestoranlar()));
                  }, child:Text("Tümünü gör"),style: TextButton.styleFrom(
                    textStyle: TextStyle(decoration: TextDecoration.underline),),),
                ],
              ),

              Container(
                height: ekranyukseklik / 5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: imgList.length, // imgList'in uzunluğu kadar öğe içerecek
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imgList[index].image, // Doğru sıradaki resmi kullan
                                fit: BoxFit.cover,
                              ),
                            ),
                            width: ekrangenislik / 1.5,
                            height: 50,
                            child: Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 120),
                                    child: Text(
                                      restorantlar[index], // Doğru sıradaki restoran adını kullan
                                      style: TextStyle(color: Colors.white, fontSize: 20.0),
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
                      return SizedBox(width: 15); // Ayırıcı eklemek için bu şekilde kullanabilirsiniz
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
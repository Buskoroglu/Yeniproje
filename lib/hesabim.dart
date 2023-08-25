import 'package:flutter/material.dart';
import 'package:yeniproje/yenieposta.dart';
import 'package:yeniproje/yeniisim.dart';
import 'package:yeniproje/yenisifre.dart';

import 'MongoDatabase.dart';

class hesabim extends StatefulWidget {

  final String mail;
  final String password;
  hesabim({required this.mail,required this.password});

  @override
  State<hesabim> createState() => _hesabimState();
}

class _hesabimState extends State<hesabim> {
  var kisiler =["Büşra Nur Özdemir","Mehmet Can Özdemir","Fındık Özdemir"];
  String? isim;
  @override
  void initState() {
    super.initState();
    getNameFromDatabase();
  }

  void getNameFromDatabase() async {
    String? userName = await MongoDatabase.findNameByMail(widget.mail);
    setState(() {
      isim = userName;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsets.all(25.0),
                  child: Text("Hesabım",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                 SizedBox (
                   width: 300,
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Ad soyad"),
                                ),
                               Padding(
                                 padding: const EdgeInsets.all(10.0),
                                 child:IconButton(onPressed:(){
                                   Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => yenisim(isim:"${isim}", mail: widget.mail)));
                                 },icon:Icon(Icons.edit)),
                               )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("${isim}",style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                    width: 300,
                      height: 150,
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("E-posta"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(widget.mail,style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>yenieposta(mail: widget.mail,)));
                                    },
                                    child: Text(
                                      "E-posta adresini güncelle",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
                                      shape: MaterialStateProperty.all<OutlinedBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15.0),
                                        ),
                                      ),
                                      side: MaterialStateProperty.all<BorderSide>(
                                        BorderSide(
                                          color: Colors.pink,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 200,
                  height: 130,
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Şifre"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: IconButton(onPressed:(){
                                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>yenisifre(sifre: widget.password, mail: widget.mail)));
                              },icon:Icon(Icons.edit)),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(widget.password,style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextButton(onPressed:(){}, child:Text("Hesabımı sil",style:TextStyle(color: Colors.pink),)),
                  )
              ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

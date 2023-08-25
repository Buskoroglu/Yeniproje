import 'package:flutter/material.dart';
import 'package:yeniproje/adreslerim.dart';

import 'MongoDatabase.dart';


class yeniadres extends StatefulWidget {
  final String mail;
  yeniadres({required this.mail});

  @override
  State<yeniadres> createState() => _yeniadresState();
}

class _yeniadresState extends State<yeniadres> {
  TextEditingController yeniadrescontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {


    Future<void> adresekle() async {
      String mail = widget.mail;
      String address = yeniadrescontroller.text;
      await MongoDatabase.insertAddressByEmail(mail, address);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 300,
              child: TextField(
                controller: yeniadrescontroller,
                decoration: InputDecoration(
                  hintText: "yeni adres giriniz ",
                ),
                maxLength: 150,
              ),
            ),
            OutlinedButton(onPressed:(){
                adresekle();
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>adreslerim(mail: widget.mail,)));
            }, child:Text("Kaydet",style: TextStyle(color: Colors.white),),
              style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              side: MaterialStateProperty.all<BorderSide>(
                BorderSide(
                  color: Colors.pink, // Kenarlık rengi
                  width: 2.0, // Kenarlık kalınlığı
                ),
              ),
            ),)
          ],
        ),
      ),
    );
  }
}

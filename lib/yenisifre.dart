import 'package:flutter/material.dart';
import 'package:yeniproje/anasayfa.dart';

import 'MongoDatabase.dart';

class yenisifre extends StatefulWidget {
  final String sifre;
  final String mail;
  yenisifre({required this.sifre,required this.mail});


  @override
  State<yenisifre> createState() => _yenisifreState();
}

class _yenisifreState extends State<yenisifre> {
  TextEditingController sifrecontroller = TextEditingController();

  Future<void> updatePassword(String email, String newPassword) async {
    await MongoDatabase.updatePasswordByEmail(email, newPassword);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text("Şifrenizi güncelleyin :",style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Card(
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15,left: 25,right: 25,top:30),
                    child: TextField(
                      controller: sifrecontroller,
                      decoration: InputDecoration(
                        hintText:widget.sifre,
                      ),
                    ),
                  ),
                  OutlinedButton(onPressed:(){
                    updatePassword(widget.mail,sifrecontroller.text);
                    print("güncelleme başarılı");
                    Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) =>anasayfa(usermail:widget.mail,password:sifrecontroller.text,)));
                  },
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
                      ),child:Text("Güncelle",style: TextStyle(color: Colors.white),))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

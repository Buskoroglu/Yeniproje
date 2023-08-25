import 'package:flutter/material.dart';
import 'package:yeniproje/hesabim.dart';

import 'MongoDatabase.dart';

class yenieposta extends StatefulWidget {
  final String mail;
  yenieposta({required this.mail});

  @override
  State<yenieposta> createState() => _yeniepostaState();
}

class _yeniepostaState extends State<yenieposta> {
  TextEditingController mailcontroller = TextEditingController();


  Future<void> updateMail(String oldMail, String newMail) async {
    await MongoDatabase.updateEmail(oldMail, newMail);
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
              child: Text("E-postanızı güncelleyin :",style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Card(
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15,left: 25,right: 25,top:30),
                    child: TextField(
                      controller: mailcontroller,
                      decoration: InputDecoration(
                        hintText:widget.mail,
                      ),
                    ),
                  ),
                  OutlinedButton(onPressed:(){
                  if(widget.mail == yenieposta){
                    print("mailler zaten aynı");
                  }
                  else if(widget.mail != yenieposta){
                    updateMail(widget.mail,mailcontroller.text);
                    print("güncelleme başarılı");
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>hesabim(mail:widget.mail, password: "")));
                  }
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

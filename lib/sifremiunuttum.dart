import 'package:flutter/material.dart';
import 'package:yeniproje/main.dart';

class sifremiunuttum extends StatefulWidget {
  const sifremiunuttum({Key? key}) : super(key: key);

  @override
  State<sifremiunuttum> createState() => _sifremiunuttumState();
}

class _sifremiunuttumState extends State<sifremiunuttum> {
  var mail ="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: Center(
                    child:Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:15,left: 12,right: 12),
                              child: Text("E-posta"),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10,bottom: 16),
                          child: TextField(
                            decoration: InputDecoration(

                            ),
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: OutlinedButton(onPressed:(){
                  Navigator.push(context,MaterialPageRoute(builder:(context)=>giris()));
                }, child:Text("şifre gönder")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

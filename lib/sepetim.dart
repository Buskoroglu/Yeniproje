import 'package:flutter/material.dart';
import 'package:yeniproje/anasayfa.dart';

class sepetim extends StatefulWidget {
  const sepetim({Key? key}) : super(key: key);

  @override
  State<sepetim> createState() => _sepetimState();
}

class _sepetimState extends State<sepetim> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/img_1.png",width: 200,height: 200,),
            Text("Sepetiniz şu an boş görünüyor.",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 20)),
            Text("Yemek ihtiyacın için hemen seçeneklere göz at!"),
            SizedBox(height: 40,),
            OutlinedButton(onPressed:(){
              Navigator.push(context,MaterialPageRoute(builder: (context) => anasayfa(usermail: "",password: "",)));
            }, child:Text("Keşfet"),
            style:OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.amber),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              backgroundColor: Colors.amber,
            ))
          ],
        ),
      ),
    );
  }
}

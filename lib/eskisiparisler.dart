import 'package:flutter/material.dart';

class eskisiparisler extends StatefulWidget {
  const eskisiparisler({Key? key}) : super(key: key);

  @override
  State<eskisiparisler> createState() => _eskisiparislerState();
}

class _eskisiparislerState extends State<eskisiparisler> {
  var restoranlar = ["hatay döner", "körfez döner", "aşçıoğlu döner", "öncü döner", "waffle lina"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
      ),
      body: Column(
        children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
             Padding(
               padding: const EdgeInsets.all(18.0),
               child: Text("Önceki Siparişlerim",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),
             ),
           ],
         ),
          Expanded(
            child: ListView.builder(
              itemCount: restoranlar.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 150,
                      child:  Row(
                       children: [
                         Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Image.asset("images/img.png", width: 50, height: 50,),
                           ],
                         ),
                         SizedBox(width: 50,),
                         Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(restoranlar[index]),
                             Text("tarih"),
                             Text("saat"),
                             SizedBox(height: 10,),
                             OutlinedButton(
                               style: OutlinedButton.styleFrom(
                                 side: BorderSide(color: Colors.pinkAccent.shade200),
                                 backgroundColor: Colors.pinkAccent.shade200
                               ),
                               onPressed: () {
                                 // Butona tıklandığında yapılacak işlemler
                               },
                               child: SizedBox(
                                 width:130,
                                 height: 40,
                                 child: Center(
                                   child: Text('Siparişi Tekrarla',style:TextStyle(color: Colors.white),),
                                 ),
                               ),
                             )
                           ],
                         ),
                         SizedBox(width: 50,),
                         Column(
                           mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                             Padding(
                               padding: const EdgeInsets.only(bottom: 100),
                               child: Text("10 TL"),
                             ),
                           ],
                         )
                       ],
                      ),
                    ),
                  ),

                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


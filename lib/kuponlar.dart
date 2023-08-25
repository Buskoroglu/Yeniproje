import 'package:flutter/material.dart';

class kuponlar extends StatefulWidget {
  const kuponlar({Key? key}) : super(key: key);

  @override
  State<kuponlar> createState() => _kuponlarState();
}

class _kuponlarState extends State<kuponlar> {
  var kuponlarim =["MAHALLE'DE 50 TL İNDİRİM","İLK SİPARİŞE ÖZEL 60TL İNDİRİM"];
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
                  padding: const EdgeInsets.all(18.0),
                  child: Text("Sana Özel Kuponlar",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: kuponlarim.length,
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
                                Image.asset("images/img_2.png", width: 50, height: 50,),
                              ],
                            ),
                            SizedBox(width: 50,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(kuponlarim[index]),
                                SizedBox(height: 50,),
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
                                      child: Text('Detayı gör',style:TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(width: 50,),
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
      ),
    );
  }
}

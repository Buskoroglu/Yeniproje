import 'package:flutter/material.dart';
import 'package:yeniproje/yeniadres.dart';
import 'MongoDatabase.dart';

class adreslerim extends StatefulWidget {
  final String mail;
  adreslerim({required this.mail});

  @override
  State<adreslerim> createState() => _adreslerimState();
}

class _adreslerimState extends State<adreslerim> {
  late Future<List<String>> adreslerFuture;

  @override
  void initState() {
    super.initState();
    adreslerFuture = adresler(widget.mail);
  }

  Future<List<String>> adresler(String mail) async {
    List<String> addresses = await MongoDatabase.getAddressesByEmail(mail);
    return addresses;
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
                  child: Text(
                    "Adreslerim",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder<List<String>>(
                future: adreslerFuture,
                builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    List<String> adreslerim = snapshot.data!;
                    return ListView.builder(
                      itemCount: adreslerim.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: 300,
                          height: 120,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Icon(Icons.location_pin),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          adreslerim[index],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          String selectedAddress = adreslerim[index];
                                          String newUserEmail = '${widget.mail}';
                                          MongoDatabase.updateAddressByEmail(newUserEmail, selectedAddress)
                                              .then((_) {
                                          })
                                              .catchError((error) {
                                            print('Error updating address: $error');
                                          });},
                                        icon: Icon(Icons.edit),),
                                      IconButton(
                                        onPressed: () {
                                          String selectedAddress = adreslerim[index];
                                          String userEmail = '${widget.mail}';

                                          MongoDatabase.deleteAddressByEmail(userEmail, selectedAddress)
                                              .then((_) {
                                          })
                                              .catchError((error) {
                                            print('Error deleting address: $error');
                                          });},
                                        icon: Icon(Icons.delete),),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text("Adresler yüklenirken bir hata oluştu."));
                  }
                },
              ),
            ),
            OutlinedButton(onPressed:(){
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>yeniadres(mail: widget.mail,)));},
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
                ),
                child:Text( "Yeni Adres Ekle",
            style: TextStyle(color: Colors.white),))
          ],
        ),
      ),
    );
  }
}


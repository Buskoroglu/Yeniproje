import 'package:flutter/material.dart';

class kategoriler extends StatefulWidget {
  const kategoriler({Key? key}) : super(key: key);

  @override
  State<kategoriler> createState() => _kategorilerState();
}

class _kategorilerState extends State<kategoriler> {

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
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("kategori"),
        ),
        body:
          Padding(
            padding: const EdgeInsets.all(45.0),
            child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 20.0,
            ),
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: Colors.deepOrange,
                child: Center(
                  child: Text(
                    items[index],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
        ),
         );},),
          ),
    );
  }
}

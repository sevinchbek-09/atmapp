import 'package:atmapp/model/xodilmar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MurojaatPage extends StatefulWidget {
  String matn;
  String bino;
  String xona;
  String bulim;
  String tel;
  bool status;
  MurojaatPage(
      {required this.matn,
      required this.bino,
      required this.xona,
      required this.bulim,
      required this.tel,
      required this.status});

  @override
  State<MurojaatPage> createState() => _State();
}

class _State extends State<MurojaatPage> {
  String selectedValue = 'Texnik bo`lim';
  final bulimlar = ['Kiber xavfsizlik', 'Texnik bo`lim', 'ATM'];
  Future<List<Xodimlar>> getXodimlar() async {
    final db = FirebaseFirestore.instance;
    var x = await db.collection('user').get().then(
        (value) => value.docs.map((e) => Xodimlar.fromJson(e.data())).toList());
    print(x);

    return x;
  }

  String? token;
  String? token1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(token);
          print(token1);
        },
      ),
      appBar: AppBar(
        title: Text('Murojaat haqida'),
      ),
      body:


      Expanded(
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Murojaat matni: ${widget.matn}',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        'Bo`lim: ${widget.bulim}',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        'Bino: ${widget.bino}',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        'Xona: ${widget.xona}',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Status: ${widget.status}',
                        style: TextStyle(fontSize: 20),
                      ),
                      Row(
                        children: [
                          Text(
                            'Telefon raqam',
                            style: TextStyle(fontSize: 20),
                          ),
                          TextButton(
                              child: Text(
                                widget.tel,
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {}),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                          
                      Expanded(child: FutureBuilder<List<Xodimlar>>(
                          future: getXodimlar(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: 1,
                                  itemBuilder: (context, index) {
                                    return DropdownButtonFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                      onTap: () {},
                                      items: snapshot.data!
                                          .map((snapshot) => DropdownMenuItem<String>(
                                        onTap: (){
                                          token1=snapshot.token;
                                        },
                                        child: Text(snapshot.ismi),
                                        value: snapshot.ismi,
                                      ))
                                          .toList(),
                                      onChanged: (String? newValue) {
                                        // setState(() {
                                        //   newValue= snapshot.data![index].ismi;
                                        //   token=newValue;
                                        // });
                                        //   newValue= snapshot.data![index].ismi;
                                        //   print(snapshot.data![index].toString());
                                        token = newValue;
                                      },
                                    );
                                  });
                          
                            }
                          
                            return Container(
                              child: Text('hello'),
                            );
                          }),)
                          
                      // DropdownButtonFormField(
                      //   decoration: InputDecoration(
                      //     border: OutlineInputBorder(),
                      //   ),
                      //   value: '1',
                      //   items: const [
                      //     DropdownMenuItem(
                      //       child: Text('Kiber xavfsizlik'),
                      //       value: '0',
                      //     ),
                      //     DropdownMenuItem(
                      //         value: '1', child: Text('Texnik bo`lim')),
                      //     DropdownMenuItem(value: '2', child: Text('ATM')),
                      //   ],
                      //   onChanged: (String? value) {
                      //     var a = int.parse(value!);
                      //     // print(a);
                      //     print(bulimlar[a]);
                      //     selectedValue = bulimlar[a];
                      //   },
                      // ),
                    ],
                  ),
                ),
                Center(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      side: BorderSide(width: 2, color: Colors.black45),
                    ),
                    onPressed: () {},
                    child: Text('Topshiriqni biriktirish'),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}

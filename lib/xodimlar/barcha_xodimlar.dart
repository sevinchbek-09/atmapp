import 'package:atmapp/xodimlar/xodimlar_id_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/xodilmar.dart';

class BarchaXodimlar extends StatefulWidget {
  const BarchaXodimlar({Key? key}) : super(key: key);

  @override
  State<BarchaXodimlar> createState() => _BarchaXodimlarState();
}

class _BarchaXodimlarState extends State<BarchaXodimlar> {
  Future<List<Xodimlar>> getAllMinds() async {
    final db = FirebaseFirestore.instance;
    return await db.collection('user').get().then(
        (value) => value.docs.map((e) => Xodimlar.fromJson(e.data())).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Barcha xodimlar'),
        ),
        body: FutureBuilder<List<Xodimlar>>(
            future: getAllMinds(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                return ListView.builder(
                    // padding: EdgeInsets.all(5),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      // print(snapshot.data![index].id);
                      // kinoId.add(snapshot.data![index].id);

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder:(context) => XodimlarIdPage(ism: snapshot.data![index].ismi,),));
                            },
                            borderRadius: BorderRadius.circular(15.0),
                            child: Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              height: 60,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    snapshot.data![index].ismi,
                                    style: TextStyle(fontSize: 26),
                                  ),
                                  Icon(Icons.chevron_right)
                                ],
                              ),
                            )),
                      );
                    });
              }

              return Container(
                child: Text('hello'),
              );
            }));
  }
}

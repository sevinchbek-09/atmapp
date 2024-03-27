import 'package:atmapp/xodimlar/Ex.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../home/murojaat_id_page.dart';
import '../model/model.dart';

class XodimlarIdPage extends StatefulWidget {
  String ism;
  XodimlarIdPage({super.key, required this.ism});

  @override
  State<XodimlarIdPage> createState() => _XodimlarIdPageState();
}

class _XodimlarIdPageState extends State<XodimlarIdPage> {
  Future<List<Murojaat>> getAllMinds() async {
    final db = FirebaseFirestore.instance;

    var x = db
        .collection('topshiriq')
        .doc(widget.ism)
        .collection('topshiriq')
        .get()
        .then((value) =>
            value.docs.map((e) => Murojaat.fromJson(e.data())).toList());

    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(widget.ism),
      ),
      body: Container(
        child: Column(
          children: [
            Card(
              child: Container(
                padding: EdgeInsets.all(7),
                height: 180,
                width: MediaQuery.of(context).size.width * 0.98,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Xodim', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.ism,
                          style: TextStyle(fontSize: 25),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder<List<Murojaat>>(
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
                              return Card(
                                child: ListTile(
                                  onTap: () {

                                  },
                                  subtitle: Text(
                                      "bino ${snapshot.data![index].xona}"),
                                  title: Text(
                                    snapshot.data![index].matn,
                                    style: TextStyle(fontSize: 22),
                                  ),
                                ),
                              );
                            });
                      }

                      return Container(
                        child: Text('hello'),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}

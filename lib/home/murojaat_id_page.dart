import 'dart:convert';
import 'package:atmapp/home/all_mind_page.dart';
import 'package:http/http.dart' as http;
import 'package:atmapp/model/xodilmar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../model/model.dart';

class MurojaatPage extends StatefulWidget {
  String matn;
  String bino;
  String xona;
  String bulim;
  String tel;
  String id;
  bool status;
  MurojaatPage(
      {required this.matn,
      required this.bino,
      required this.xona,
      required this.bulim,
      required this.tel,
      required this.id,
      required this.status});

  @override
  State<MurojaatPage> createState() => _State();
}

class _State extends State<MurojaatPage> {
  String selectedValue = 'Texnik bo`lim';
  final bulimlar = ['Kiber xavfsizlik', 'Texnik bo`lim', 'ATM'];
  Future pushNotificationsSpecificDevice() async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAADgN57kM:APA91bGA_626Yc_KUlSwNwP1NHOodpEeXy4UxZSQBOyigN34GFP-0Skh6NjOTtqeINiDPo0cho-7oyBPLnjFf6WytpWibgNQnQxWd-wckzX1AwqMucSD0rRPlQy4VF8rYsbENd7G5gYZ'
    };
    var request =
        http.Request('POST', Uri.parse('https://fcm.googleapis.com/fcm/send'));
    request.body = json.encode({
      "to": "$token1",
      "notification": {
        "title": widget.matn,
        "body": "${widget.matn} ${widget.bino}bino ${widget.xona} xona"
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<List<Xodimlar>> getXodimlar() async {
    final db = FirebaseFirestore.instance;
    var x = await db.collection('user').get().then(
        (value) => value.docs.map((e) => Xodimlar.fromJson(e.data())).toList());
    print(x);

    return x;
  }

  String? ism;
  String? token1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Murojaat haqida'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
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

                      ],
                    ),
                    Text('Xodimlar', style: TextStyle(fontSize: 20)),

                    Expanded(
                      child: FutureBuilder<List<Xodimlar>>(
                          future: getXodimlar(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
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
                                          .map((snapshot) =>
                                              DropdownMenuItem<String>(
                                                onTap: () {
                                                  token1 = snapshot.token;
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
                                        ism = newValue;
                                      },
                                    );
                                  });
                            }

                            return Container(
                              child: Text('hello'),
                            );
                          }),
                    )
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
                  onPressed: () async {
                    if (token1 != null && ism != null) {
                      await pushNotificationsSpecificDevice();
                      var x = DateTime.now();
                      final db = FirebaseFirestore.instance;
                      Murojaat murojaat = Murojaat(
                          matn: widget.matn,
                          bino: widget.bino,
                          xona: widget.xona,
                          bulim: widget.bulim,
                          tel: widget.tel,
                          id: widget.id,
                          status: false);
                      await db
                          .collection('topshiriq')
                          .doc('$ism')
                          .collection('topshiriq')
                          .doc(x.toString())
                          .set(murojaat.toJson());

                      await db
                          .collection('murojaat')
                          .doc(widget.id)
                          .update({"status": true});
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) =>
                                  AllMindsPage()),
                              (Route<dynamic> route) => false);
                    } else {
                      showAlertDialog(context);
                    }
                  },
                  child: Text('Topshiriqni biriktirish'),
                ),
              )
            ]),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Xatolik"),
      content: Text("Xodimni tanlang"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

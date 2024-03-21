import 'package:atmapp/home/murojaat_id_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';

import '../authorization/getToken/get_token.dart';
import '../model/model.dart';

class AllMindsPage extends StatefulWidget {
  const AllMindsPage({Key? key}) : super(key: key);

  @override
  State<AllMindsPage> createState() => _AllMindsPageState();
}

class _AllMindsPageState extends State<AllMindsPage> {
  final box = GetStorage();
  int a = 0;

  @override
  Widget build(BuildContext context) {
    Future<List<Murojaat>> getAllMinds() async {
      final db = FirebaseFirestore.instance;
      return await db.collection('murojaat').get().then((value) =>
          value.docs.map((e) => Murojaat.fromJson(e.data())).toList());
    }

    Future refresh() async {
      final db = FirebaseFirestore.instance;

      var x = await db.collection('murojaat').get().then((value) =>
          value.docs.map((e) => Murojaat.fromJson(e.data())).toList());
      // print(x.isNotEmpty);
      if (x.isNotEmpty) {
        setState(() {
          x;
        });
      }
    }

    return Scaffold(
      drawer: drawer(),
      appBar: AppBar(
        title: Text('Barcha murojaatlar'),
        actions: [
          IconButton(
              onPressed: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => HomePage(id:a),
                // ));
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => GetToken()));
              },
              icon: Icon(Icons.add)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
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
                      // print(snapshot.data![index].id);
                      // kinoId.add(snapshot.data![index].id);

                      return Card(
                        child: Container(
                          decoration: BoxDecoration(
                              color: snapshot.data![index].status == true
                                  ? Colors.green[300]
                                  : Colors.red[300],
                              borderRadius: BorderRadius.circular(14.0)),
                          child: ListTile(
                            onTap: () {
                              
                              print("INDEKS");
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MurojaatPage(
                                    matn: snapshot.data![index].matn,
                                    bino: snapshot.data![index].bino,
                                    bulim: snapshot.data![index].bulim,
                                    xona: snapshot.data![index].xona,
                                    status: snapshot.data![index].status,
                                    tel: snapshot.data![index].tel),
                              ));
                            },
                            subtitle:
                                Text("bino ${snapshot.data![index].bino}"),
                            title: Text(
                              snapshot.data![index].matn,
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                      );
                    });
              }

              return Container(
                child: Text('hello'),
              );
            }),
      ),
    );
  }
}

Widget drawer() {
  return Drawer(
      child: ListView(
    padding: EdgeInsets.zero,
    children: [
      UserAccountsDrawerHeader(
        accountName: Text('Muhlis'),
        accountEmail: Text('RTTM boshlig`i'),
        decoration: BoxDecoration(
          color: Colors.blue.shade800,
            image: DecorationImage(
          image: AssetImage('assets/images/a.png',),
        )),
      ),
      SizedBox(height: 10,),
      ListTile(onTap: (){},
        leading: Icon(Icons.people_alt),
        title: Text('Xodimlar'),
      ),
      SizedBox(height: 10,),
      ListTile(onTap: (){},
        leading: Icon(Icons.add),
        title: Text('Post token'),
      )
    ],
  ));
}

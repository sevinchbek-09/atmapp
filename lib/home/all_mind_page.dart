
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class AllMindsPage extends StatefulWidget {
  const AllMindsPage({Key? key}) : super(key: key);

  @override
  State<AllMindsPage> createState() => _AllMindsPageState();
}

class _AllMindsPageState extends State<AllMindsPage> {
  final box = GetStorage();
  String tk='';
  int a = 0;
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    tk;
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    // Future<List<KinoModel>> getAllMinds() async {
    //   final db = FirebaseFirestore.instance;
    //
    //   return await db.collection('kino').get().then((value) =>
    //       value.docs.map((e) => KinoModel.fromJson(e.data())).toList());
    // }
    //
    // Future refresh() async {
    //   final db = FirebaseFirestore.instance;
    //
    //   var x = await db.collection('kino').get().then((value) =>
    //       value.docs.map((e) => KinoModel.fromJson(e.data())).toList());
    //   // print(x.isNotEmpty);
    //   if (x.isNotEmpty) {
    //     setState(() {
    //       x;
    //     });
    //   }
    // }

    return Scaffold(
        appBar: AppBar(
          title: Text('Barcha kinolar'),
          actions: [
            IconButton(
                onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) => HomePage(id: a),
                  // ));
                },
                icon: Icon(Icons.add)),
            IconButton(
                onPressed: () {
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (context) => BuyPage()));
                },
                icon: Icon(Icons.shopping_cart)),
            IconButton(
                onPressed: () {
                  // Navigator.of(context).pushAndRemoveUntil(
                  //     MaterialPageRoute(builder: (context) => MyApp()),
                  //     (Route<dynamic> route) => false);
                  // box.remove('UID');
                },
                icon: Icon(Icons.logout)),
          ],
        ),
        body: Center(
            child: Container(
          child: Column(
            children: [
              Text('Token${tk}'),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(onPressed: ()async {

                String? token= await FirebaseMessaging.instance.getToken();
                print(token);
                tk=token!;
                setState(() {tk;});

              }, child: Text('Get Token'))
            ],
          ),
        ))

        // RefreshIndicator(
        //   onRefresh: refresh,
        //   child: FutureBuilder<List<KinoModel>>(
        //       future: getAllMinds(),
        //       builder: (context, snapshot) {
        //         if (snapshot.connectionState == ConnectionState.waiting) {
        //           return Center(child: CircularProgressIndicator());
        //         }
        //         if (snapshot.hasData) {
        //           a = snapshot.data!.last.id;
        //
        //           return ListView.builder(
        //               padding: EdgeInsets.all(5),
        //               itemCount: snapshot.data!.length,
        //               itemBuilder: (context, index) {
        //                 // print(snapshot.data![index].id);
        //
        //                 // kinoId.add(snapshot.data![index].id);
        //
        //                 return InkWell(
        //                   onTap: () async {
        //                     print(snapshot.data![index].id);
        //                     Navigator.push(
        //                         context,
        //                         MaterialPageRoute(
        //                             builder: (context) => UrindiqPage(
        //                                 id: snapshot.data![index].id,
        //                                 rasm: snapshot.data![index].rasm)));
        //                   },
        //                   child: Card(
        //                     shape: const OutlineInputBorder(
        //                         borderRadius:
        //                             BorderRadius.all(Radius.circular(15)),
        //                         borderSide: BorderSide(color: Colors.white)),
        //                     child: Container(
        //                       margin: EdgeInsets.all(1),
        //                       height: 300,
        //                       width: 200,
        //                       decoration: BoxDecoration(
        //                         borderRadius: BorderRadius.circular(15),
        //                         image: DecorationImage(
        //                             image:
        //                                 NetworkImage(snapshot.data![index].rasm),
        //                             fit: BoxFit.cover),
        //                       ),
        //                       child: Container(
        //                         padding: EdgeInsets.all(10),
        //                         decoration: BoxDecoration(
        //                           borderRadius: BorderRadius.circular(15),
        //                           gradient: LinearGradient(
        //                               begin: Alignment.bottomRight,
        //                               colors: [
        //                                 Colors.black.withOpacity(.7),
        //                                 Colors.black.withOpacity(.5),
        //                                 Colors.black.withOpacity(.2),
        //                                 Colors.black.withOpacity(.0)
        //                               ]),
        //                         ),
        //                         child: Row(
        //                           crossAxisAlignment: CrossAxisAlignment.end,
        //                           mainAxisAlignment: MainAxisAlignment.start,
        //                           children: [
        //                             Text(
        //                               snapshot.data![index].nomi,
        //                               style: TextStyle(
        //                                   color: Colors.white, fontSize: 25),
        //                             )
        //                           ],
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 );
        //               });
        //         }
        //
        //         return Container(
        //           child: Text('hello'),
        //         );
        //       }),
        // ),

        );
  }
}

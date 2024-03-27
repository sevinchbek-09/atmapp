import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../home/all_mind_page.dart';

class GetToken extends StatefulWidget {
  const GetToken({super.key});

  @override
  State<GetToken> createState() => _GetTokenState();
}

class _GetTokenState extends State<GetToken> {
  TextEditingController ism = TextEditingController();
  String token='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tokenni kiritish'),
      ),
      body:  Container(
        padding: EdgeInsets.all(10),

        child: Column(
          
          children: [
            SizedBox(height: 25,),
            Text('Tokenni post qilsangiz sizga bildirish nomalar kela boshlaydi'),
              SizedBox(height: 10,),

              ElevatedButton(onPressed: ()async{
                setState(() {
                  token;
                });
                token=(await FirebaseMessaging.instance.getToken())!;
                print(token);

              }, child: Text('Get')),
            SizedBox(height: 10,),
            Text(token,maxLines: 2),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: ()async{
              final db = FirebaseFirestore.instance;
              await db
                  .collection('id')
                  .doc('1')
                  .update({"token": token});
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) =>
                          AllMindsPage()),
                      (Route<dynamic> route) => false);
            }, child: Text('Post',))
          ],
        ),
      ),
    );
  }
}

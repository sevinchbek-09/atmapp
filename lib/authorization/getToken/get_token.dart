import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(),
      body:  Container(
        padding: EdgeInsets.all(10),

        child: Column(
          
          children: [
            SizedBox(height: 25,),
              TextField(
                controller: ism,
                decoration: InputDecoration(
                  label: Text('Ismingiz'),
                  border:  OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.teal)
                  ),
                ),
                
              ),
              SizedBox(height: 10,),

              ElevatedButton(onPressed: ()async{
                setState(() {
                  token;
                });
                token=(await FirebaseMessaging.instance.getToken())!;
                print(token);

              }, child: Text('get')),
            SizedBox(height: 10,),
            Text(token)
          ],
        ),
      ),
    );
  }
}

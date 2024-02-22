import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../home/all_mind_page.dart';


class SingUpPage extends StatelessWidget {
  SingUpPage({Key? key}) : super(key: key);
  final box = GetStorage();
  TextEditingController email = TextEditingController();
  TextEditingController pasword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sing Up Page'),

      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('Ro`yhatdan o`tish'),
            const SizedBox(
              height: 35,
            ),
            TextField(
              controller: email,
              decoration: InputDecoration(
                  label: Text('Email'), border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 35,
            ),
            TextField(
              controller: pasword,
              decoration: const InputDecoration(
                  label: Text('Password'), border: OutlineInputBorder()),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            final db = FirebaseFirestore.instance;
            UserCredential userCredential =
                await auth.createUserWithEmailAndPassword(
                    email: email.text, password: pasword.text);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>  AllMindsPage(),
                ));
            box.write('UID', userCredential.user?.uid);
            db.collection('buy').doc('${userCredential.user?.uid}').
            collection('kino');
            db.collection('buy').doc('${userCredential.user?.uid}').
            collection('info').doc('1').set({
              "ism":'Qwera',
              "familiya":'Flutter',
              "UID":'${box.read('UID')}'

            });


            print(userCredential.user?.uid);
          } catch (e) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
          }
        },
        child: Icon(Icons.login),
      ),
    );
  }
}

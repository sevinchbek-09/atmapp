import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../home/all_mind_page.dart';
import '../sing_up/sing_up_page.dart';

class SingInPage extends StatelessWidget {
  SingInPage({Key? key}) : super(key: key);
  final box = GetStorage();
  TextEditingController email = TextEditingController();
  TextEditingController pasword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sing In Page'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SingUpPage()));
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('Kirish'),
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
            UserCredential userCredential =
                await auth.signInWithEmailAndPassword(
                    email: email.text, password: pasword.text);

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AllMindsPage(),
                ));
            box.write('UID', userCredential.user?.uid);
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

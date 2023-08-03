import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
        ),
        drawer: Drawer(
            backgroundColor: Colors.white,
            child: ListView(children: [
              ListTile(
                  title: Text('Sign up',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  onTap: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(builder: (context) {
                    //     return WeatherNews();
                    //   }),
                    // );
                  }),
            ])),
        body: Center(
            child: Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'メールアドレス'),
                        onChanged: (String value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'パスワード'),
                        obscureText: true,
                        onChanged: (String value) {
                          setState(() {
                            password = value;
                          });
                        },
                      ),
                      // 3行目 ユーザ登録ボタン
                      ElevatedButton(
                        child: const Text('ユーザ登録'),
                        onPressed: () async {
                          try {
                            final User? user = (await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: email, password: password))
                                .user;
                            if (user != null)
                              print("ユーザ登録しました ${user.email} , ${user.uid}");
                          } catch (e) {
                            print(e);
                          }
                        },
                      )
                    ]))));
  }
}

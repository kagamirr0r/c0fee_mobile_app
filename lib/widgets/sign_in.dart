import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '/widgets/welcome.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // 入力したメールアドレス・パスワード
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 1行目 メールアドレス入力用テキストフィールド
              TextFormField(
                decoration: const InputDecoration(labelText: 'メールアドレス'),
                onChanged: (String value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              // 2行目 パスワード入力用テキストフィールド
              TextFormField(
                decoration: const InputDecoration(labelText: 'パスワード'),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    _password = value;
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
                                email: _email, password: _password))
                        .user;
                    if (user != null) {
                      print(user);
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return Welcome();
                        }),
                      );
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              // 4行目 ログインボタン
              // ElevatedButton(
              //   child: const Text('ログイン'),
              //   onPressed: () async {
              //     try {
              //       // メール/パスワードでログイン
              //       final User? user = (await FirebaseAuth.instance
              //               .signInWithEmailAndPassword(
              //                   email: _email, password: _password))
              //           .user;
              //       if (user != null)
              //         print("ログインしました　${user.email} , ${user.uid}");
              //     } catch (e) {
              //       print(e);
              //     }
              //   },
              // ),
              // // 5行目 パスワードリセット登録ボタン
              // ElevatedButton(
              //     child: const Text('パスワードリセット'),
              //     onPressed: () async {
              //       try {
              //         await FirebaseAuth.instance
              //             .sendPasswordResetEmail(email: _email);
              //         print("パスワードリセット用のメールを送信しました");
              //       } catch (e) {
              //         print(e);
              //       }
              //     }),
            ],
          ),
        ),
      ),
    );
  }
}

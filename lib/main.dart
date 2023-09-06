import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import '/widgets/sign_in.dart';
import '/widgets/sign_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'C0fee',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'C0fee'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 入力したメールアドレス・パスワード
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[900],
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ButtonStyle()
                child: const Text('Sign In'),
                onPressed: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return SignIn();
                    }),
                  );
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

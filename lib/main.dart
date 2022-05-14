import 'package:annachhatra/HomeScreen/HomeScreen.dart';
import 'package:annachhatra/LoginScreen/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: FirebaseAuth.instance.currentUser != null
                  ? HomeScreen(
                      name: FirebaseAuth.instance.currentUser?.displayName)
                  : LoginScreen(),
            );
          } else {
            return const MaterialApp(
              home: Scaffold(),
            );
          }
        });
  }
}

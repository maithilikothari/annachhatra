import 'package:annachhatra/RegistrationScreen/RegistrationScreen.dart';
import 'package:annachhatra/utils/ColorPallet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../HomeScreen/HomeScreen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key key}) : super(key: key);
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.maxFinite, 200),
          child: Material(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                  right: 20,
                  left: 20,
                  bottom: 20),
              height: double.maxFinite,
              width: double.maxFinite,
              color: ColorPallet().primaryColor,
              alignment: Alignment.bottomLeft,
              child: const Text(
                'Annachhatra',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Log In',
                style: TextStyle(
                    color: ColorPallet().primaryColor,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: 'e-mail'),
                onChanged: (value) {
                  email = value;
                },
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: 'password'),
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 30),
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationScreen()));
                  },
                  child: const Text(
                    'Not Registered ?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              Center(
                child: RawMaterialButton(
                    shape: const StadiumBorder(),
                    fillColor: ColorPallet().accentColor,
                    onPressed: () async {
                      if (email != '') {
                        if (password != '') {
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email, password: password)
                                .then((value) => {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HomeScreen(
                                                    name:
                                                        value.user?.displayName,
                                                  )),
                                          (route) => false)
                                    });
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'No user found for that email.')));
                            } else if (e.code == 'wrong-password') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Wrong password provided for that user.')));
                            }
                          }
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Enter Password please'),
                          ));
                        }
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Enter email please'),
                        ));
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: ColorPallet().textColor,
                          fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
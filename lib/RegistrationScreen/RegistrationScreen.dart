import 'dart:io';

import 'package:annachhatra/HomeScreen/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/ColorPallet.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController emailController = TextEditingController(),
      passController = TextEditingController(),
      nameController = TextEditingController(),
      verpassController = TextEditingController();

  String email = '', password = '', name = '', verpass = '';
  File imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPallet().primaryColor,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Registration',
                        style: TextStyle(
                            fontSize: 30,
                            color: ColorPallet().primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            PickedFile pickedFile = await ImagePicker()
                                .getImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 30);
                            if (pickedFile != null) {
                              setState(() {
                                imageFile = File(pickedFile.path);
                              });
                            }
                          },
                          child: Container(
                            color: Colors.black12.withOpacity(0.5),
                            height: 200,
                            width: 200,
                            child: imageFile == null
                                ? Icon(Icons.image)
                                : Image.file(imageFile),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (value) {
                          name = value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Organization/hotel name',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'email',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        obscureText: true,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Create 6 digit Password',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        obscureText: true,
                        onChanged: (value) {
                          verpass = value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Verify 6 digit Password',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: MaterialButton(
                          onPressed: () async {
                            if (name != '') {
                              if (email != '') {
                                if (password != '') {
                                  if (verpass != '') {
                                    if (password == verpass) {
                                      try {
                                        await FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                          email: email,
                                          password: password,
                                        )
                                            .then((result) async {
                                          await result.user
                                              ?.updateDisplayName(name);
                                          if (imageFile != null) {
                                            FirebaseStorage.instance
                                                .ref('user')
                                                .child(email)
                                                .putFile(imageFile)
                                                .then((p0) => Navigator
                                                    .pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    HomeScreen(
                                                                      name: result
                                                                          .user
                                                                          ?.displayName,
                                                                    )),
                                                        (route) => false));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content:
                                                        Text('Provide Image')));
                                          }
                                        });
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'weak-password') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'The password provided is too weak.')));
                                        } else if (e.code ==
                                            'email-already-in-use') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'The account already exists for that email.')));
                                        }
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Something went wrong')));
                                        print(e);
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Oops Password Don't Match !")));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Provide Verification Password")));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("Provide Password")));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Provide email")));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Provide name")));
                            }
                          },
                          shape: const StadiumBorder(),
                          color: ColorPallet().accentColor,
                          child: Text(
                            "Register",
                            style: TextStyle(
                                color: ColorPallet().textColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

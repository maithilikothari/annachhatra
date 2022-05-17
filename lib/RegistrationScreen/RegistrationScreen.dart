import 'dart:io';

import 'package:annachhatra/HomeScreen/HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  bool loading;

  @override
  void initState() {
    loading = false;
  }

  Reference storageReference = FirebaseStorage.instance.ref();

  Future<bool> createUser(String url) async {
    final firestore = FirebaseFirestore.instance;
    try {
      await firestore
          .collection('users')
          .doc(email)
          .set({'name': name, 'email': email, 'id': email, 'profile': url});
      return true;
    } catch (exception) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(exception.toString())));
      return false;
    }
  }

  Future<String> uploadPic(File file, String id) async {
    final storageRef = FirebaseStorage.instance.ref();

// Create a reference to "mountains.jpg"
    final dpRef = storageRef.child("$id.jpg");

// Create a reference to 'images/mountains.jpg'
    final dpImagesRef = storageRef.child("images/$id.jpg");

// While the file names are the same, the references point to different files
    assert(dpRef.name == dpImagesRef.name);
    assert(dpRef.fullPath != dpImagesRef.fullPath);
    try {
      await dpRef.putFile(file);
      String url = await dpRef.getDownloadURL();
      return url;
    } catch (e) {
      print(e.toString());
      return null;
      // ...
    }
  }

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
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: AspectRatio(
                            aspectRatio: 80 / 80,
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
                              child: Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: imageFile == null
                                      ? Icon(
                                          Icons.image,
                                          color: ColorPallet().primaryColor,
                                          size: 60,
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: FileImage(imageFile)),
                                          ),
                                        ),
                                ),
                              ),
                            ),
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
                        child: loading
                            ? SpinKitCircle(
                                color: ColorPallet().accentColor,
                              )
                            : SizedBox(
                                width: 200,
                                child: MaterialButton(
                                  onPressed: () async {
                                    if (name != '') {
                                      if (email != '') {
                                        if (password != '') {
                                          if (verpass != '') {
                                            if (password == verpass) {
                                              try {
                                                setState(() {
                                                  loading = true;
                                                });
                                                await FirebaseAuth.instance
                                                    .createUserWithEmailAndPassword(
                                                  email: email,
                                                  password: password,
                                                )
                                                    .then((result) async {
                                                  await result.user
                                                      ?.updateDisplayName(name);
                                                  if (imageFile != null) {
                                                    String imageUrl;
                                                    try {
                                                      imageUrl =
                                                          await uploadPic(
                                                              imageFile, email);
                                                      if (imageUrl != null) {
                                                        bool success =
                                                            await createUser(
                                                                imageUrl);
                                                        if (success) {
                                                          Navigator
                                                              .pushAndRemoveUntil(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              HomeScreen(
                                                                                name: result.user?.displayName,
                                                                              )),
                                                                  (route) =>
                                                                      false);
                                                        } else {
                                                          setState(() {
                                                            loading = false;
                                                          });
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  const SnackBar(
                                                                      content: Text(
                                                                          'Something Went Wrong while Creating a User')));
                                                        }
                                                      } else {
                                                        setState(() {
                                                          loading = false;
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  const SnackBar(
                                                                      content: Text(
                                                                          'Something Went Wrong while Uploading Image')));
                                                        });
                                                      }
                                                    } catch (exception) {
                                                      setState(() {
                                                        loading = false;
                                                      });
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(SnackBar(
                                                              content: Text(
                                                                  exception
                                                                      .toString())));
                                                      if (imageUrl != null) {
                                                        print(imageUrl);
                                                      } else {
                                                        print(
                                                            'imageUrl is not get');
                                                      }
                                                    }
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'Provide Image')));
                                                  }
                                                });
                                              } on FirebaseAuthException catch (e) {
                                                setState(() {
                                                  loading = false;
                                                });
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
                                              }
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Oops Password Don't Match !")));
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Provide Verification Password")));
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Provide Password")));
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content:
                                                    Text("Provide email")));
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
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

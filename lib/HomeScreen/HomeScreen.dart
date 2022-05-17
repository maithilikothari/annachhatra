import 'package:annachhatra/HomeScreen/Widgets/GeneratePickUpOrderDialogue.dart';
import 'package:annachhatra/LoginScreen/LoginScreen.dart';
import 'package:annachhatra/utils/ColorPallet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key, this.name}) : super(key: key);
  final String name;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth user;
  String name;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance;
  }

  final _fireStoreUsersCollection =
      FirebaseFirestore.instance.collection('users');
  final _fireStoreOrdersCollection =
      FirebaseFirestore.instance.collection('orders');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: _fireStoreUsersCollection
            .doc(FirebaseAuth.instance.currentUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            name = snapshot.data.get('name');
            return Scaffold(
              drawer: Drawer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: ColorPallet().accentColor,
                      ),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.transparent,
                                backgroundImage:
                                    NetworkImage(snapshot.data.get('profile')),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Icon(
                            Icons.volunteer_activism,
                            color: ColorPallet().textColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'View Donations',
                            style: TextStyle(color: ColorPallet().textColor),
                          ),
                        ],
                      ),
                      onTap: () {
                        // Update the state of the app.
                        // ...
                      },
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Icon(
                            Icons.add_shopping_cart,
                            color: ColorPallet().textColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'My Pick Ups',
                            style: TextStyle(color: ColorPallet().textColor),
                          ),
                        ],
                      ),
                      onTap: () {
                        // Update the state of the app.
                        // ...
                      },
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: ColorPallet().textColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Log Out',
                            style: TextStyle(color: ColorPallet().textColor),
                          ),
                        ],
                      ),
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (route) => false);
                        // Update the state of the app.
                        // ...
                      },
                    ),
                  ],
                ),
              ),
              appBar: AppBar(
                title: const Text(
                  'Anna Chhatra',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const GeneratePickUpOrderDialogue();
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: const [
                          Text(
                            'Donate',
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(Icons.fastfood),
                        ],
                      ),
                    ),
                  )
                ],
                backgroundColor: ColorPallet().primaryColor,
              ),
              body: StreamBuilder<QuerySnapshot>(
                  stream: _fireStoreOrdersCollection.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          if (snapshot.data.docs.isNotEmpty) {
                            DocumentSnapshot userData =
                                snapshot.data.docs[index];
                            return Text('');
                          } else {
                            return const Center(
                                child: Text(
                              'No Active Order To Show',
                              style: TextStyle(color: Colors.grey),
                            ));
                          }
                        },
                      );
                    } else if (snapshot.connectionState ==
                            ConnectionState.active ||
                        snapshot.connectionState == ConnectionState.active) {
                      return Center(
                          child: const Text('No Active Order To Show'));
                    } else {
                      return SpinKitCircle(
                        color: ColorPallet().primaryColor,
                      );
                    }
                  }),
            );
          } else {
            return Scaffold(
              body: Container(),
            );
          }
        });
  }
}

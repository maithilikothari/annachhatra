import 'package:annachhatra/HomeScreen/Widgets/AddDishListTab.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';

import '../../utils/ColorPallet.dart';

class GeneratePickUpOrderDialogue extends StatefulWidget {
  const GeneratePickUpOrderDialogue({Key key}) : super(key: key);
  @override
  State<GeneratePickUpOrderDialogue> createState() =>
      _GeneratePickUpOrderDialogueState();
}

class _GeneratePickUpOrderDialogueState
    extends State<GeneratePickUpOrderDialogue> {
  String url;
  bool isNonVeg, loading;
  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  @override
  void initState() {
    isNonVeg = false;
    loading = false;
    super.initState();
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  final _fireStoreUsersCollection =
      FirebaseFirestore.instance.collection('users');
  final _fireStoreOrdersCollection =
      FirebaseFirestore.instance.collection('orders');

  String dishName = '';
  String quantity = '';
  List<Map> dishes = [];
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: _fireStoreUsersCollection
            .doc(FirebaseAuth.instance.currentUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            url = snapshot.data.get('profile');
            return Dialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height - 140,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(url), fit: BoxFit.cover),
                              color: Colors.grey,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                        ),
                      ),
                      Expanded(
                          flex: 8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  snapshot.data.get('name'),
                                  style: TextStyle(
                                      color: ColorPallet().textColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TextField(
                                      decoration: const InputDecoration(
                                          hintText: 'Dish Name'),
                                      onChanged: (value) {
                                        dishName = value;
                                      },
                                      textCapitalization:
                                          TextCapitalization.words,
                                      controller: nameController,
                                      keyboardType: TextInputType.name,
                                    ),
                                    TextField(
                                      decoration: const InputDecoration(
                                        hintText: 'Quantity',
                                      ),
                                      onChanged: (value) {
                                        quantity = value;
                                        try {
                                          i = i + int.parse(quantity);
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
                                      controller: quantityController,
                                      keyboardType: TextInputType.number,
                                    ),
                                    RawMaterialButton(
                                      elevation: 0,
                                      onPressed: () {
                                        setState(() {
                                          dishes.add({
                                            'name': dishName,
                                            'quantity': quantity
                                          });
                                          nameController.clear();
                                          quantityController.clear();
                                        });
                                      },
                                      shape: const StadiumBorder(),
                                      child: const Text("+ Add"),
                                      fillColor: Colors.white,
                                      textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: ColorPallet().accentColor),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height: 120,
                                      child: dishes.isNotEmpty
                                          ? ListView(
                                              children: dishes
                                                  .map((e) => AddDishListTab(
                                                        dishName: e['name'],
                                                        quantity: e['quantity'],
                                                        index: e,
                                                        onDelete: (value) {
                                                          setState(() {
                                                            dishes
                                                                .remove(value);
                                                          });
                                                        },
                                                      ))
                                                  .toList(),
                                            )
                                          : Text(
                                              'Add the dish',
                                              style: TextStyle(
                                                  color:
                                                      ColorPallet().textColor),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                      Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                      value: isNonVeg,
                                      onChanged: (value) {
                                        setState(() {
                                          isNonVeg
                                              ? isNonVeg = false
                                              : isNonVeg = true;
                                        });
                                      }),
                                  Text('Non-Veg')
                                ],
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    loading
                                        ? SpinKitCircle(
                                            color: ColorPallet().accentColor,
                                          )
                                        : MaterialButton(
                                            elevation: 4,
                                            color: ColorPallet().accentColor,
                                            shape: const StadiumBorder(),
                                            child: const Text('Generate'),
                                            onPressed: () async {
                                              if (dishes.isNotEmpty) {
                                                String id = FirebaseAuth
                                                        .instance
                                                        .currentUser
                                                        .email
                                                        .toString() +
                                                    DateTime.now()
                                                        .millisecondsSinceEpoch
                                                        .toString();
                                                Position position =
                                                    await _determinePosition();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(position
                                                            .toString())));
                                                setState(() {
                                                  loading = true;
                                                });
                                                _fireStoreOrdersCollection.add({
                                                  'id': id,
                                                  'location': GeoPoint(
                                                      position.latitude,
                                                      position.longitude),
                                                  'available': true,
                                                  'ownerId': FirebaseAuth
                                                      .instance
                                                      .currentUser
                                                      .email
                                                      .toString(),
                                                  'allotedId': '',
                                                  'isNonVeg': isNonVeg,
                                                  'totalQuantity': i,
                                                  'hotelName':
                                                      snapshot.data.get('name'),
                                                  'profile': snapshot.data
                                                      .get('profile'),
                                                }).then((value) async {
                                                  for (Map a in dishes) {
                                                    await value
                                                        .collection('items')
                                                        .doc(DateTime.now()
                                                            .millisecondsSinceEpoch
                                                            .toString())
                                                        .set({
                                                      'name': a['name'],
                                                      'quantity': a['quantity']
                                                    });
                                                  }
                                                  setState(() {
                                                    loading = false;
                                                  });
                                                  Navigator.pop(context);
                                                });
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            'Add the Dishes')));
                                              }
                                            },
                                            textColor: ColorPallet().textColor,
                                          )
                                  ],
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Dialog();
          }
        });
    ;
  }
}

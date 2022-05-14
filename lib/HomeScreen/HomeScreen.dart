import 'package:annachhatra/LoginScreen/LoginScreen.dart';
import 'package:annachhatra/utils/ColorPallet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key, this.name}) : super(key: key);
  final name;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth user;
  String name;

  @override
  void initState() {
    user = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    name = FirebaseAuth.instance.currentUser.displayName;
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
                  child: Text(
                    FirebaseAuth.instance.currentUser?.displayName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
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
                    MaterialPageRoute(builder: (context) => LoginScreen()),
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
            onTap: () {},
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
      body: ListView(
        children: const [
          HotelTab(
            hotelName: 'Hotel Lalitaditya',
            quantity: '2',
            orderId: '12345',
            isVeg: true,
          ),
        ],
      ),
    );
  }
}

class HotelTab extends StatelessWidget {
  const HotelTab({
    Key key,
    this.hotelName,
    this.quantity,
    this.orderId,
    this.isVeg,
  }) : super(key: key);
  final String hotelName;
  final bool isVeg;
  final String quantity;
  final String orderId;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 2,
        child: SizedBox(
          height: MediaQuery.of(context).size.aspectRatio * 500,
          width: double.maxFinite,
          child: Column(
            children: [
              Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorPallet().accentColor.withOpacity(0.5),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20)),
                              color: isVeg
                                  ? ColorPallet().vegColor.withOpacity(0.5)
                                  : ColorPallet().nonVegColor.withOpacity(0.5),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Quantity',
                                  style: TextStyle(
                                      color: isVeg
                                          ? ColorPallet().textColor
                                          : Colors.white,
                                      fontSize: 15),
                                ),
                                Text(
                                  quantity,
                                  style: TextStyle(
                                      color: isVeg
                                          ? ColorPallet().textColor
                                          : Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  hotelName,
                                  style: TextStyle(
                                      color: ColorPallet().textColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: MaterialButton(
                                    onPressed: () {
                                      showAlertDialogOfHotel(context);
                                    },
                                    shape: const StadiumBorder(),
                                    color: ColorPallet().accentColor,
                                    child: const Text(
                                      'View',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialogOfHotel(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PickUpRequestDialogue();
      },
    );
  }
}

class PickUpRequestDialogue extends StatefulWidget {
  const PickUpRequestDialogue({
    Key key,
  }) : super(key: key);

  @override
  State<PickUpRequestDialogue> createState() => _PickUpRequestDialogueState();
}

class _PickUpRequestDialogueState extends State<PickUpRequestDialogue> {
  bool pickupRequest;

  @override
  void initState() {
    pickupRequest = false;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        height: MediaQuery.of(context).size.height - 140,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
              ),
            ),
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Hotel Lalitaditya',
                        style: TextStyle(
                            color: ColorPallet().textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                      height: 200,
                      child: pickupRequest
                          ? Center(
                              child: const Text(
                                "Request Accepted",
                                style: TextStyle(
                                    color: Colors.green, fontSize: 20),
                              ),
                            )
                          : ListView(
                              children: const [
                                foodItems(
                                  name: 'Chicken Biryani',
                                  quantity: '22',
                                ),
                              ],
                            ),
                    ),
                  ],
                )),
            Expanded(
                flex: 1,
                child: Container(
                  child: pickupRequest
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              elevation: 4,
                              color: ColorPallet().accentColor,
                              shape: StadiumBorder(),
                              child: Text('Done'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              textColor: ColorPallet().textColor,
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              elevation: 4,
                              shape: StadiumBorder(),
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              textColor: ColorPallet().accentColor,
                            ),
                            MaterialButton(
                              elevation: 4,
                              color: ColorPallet().accentColor,
                              shape: StadiumBorder(),
                              child: Text('Pick Up'),
                              onPressed: () {
                                setState(() {
                                  pickupRequest = true;
                                });
                              },
                              textColor: ColorPallet().textColor,
                            )
                          ],
                        ),
                ))
          ],
        ),
      ),
    );
  }
}

class foodItems extends StatelessWidget {
  const foodItems({
    Key key,
    this.name,
    this.quantity,
  }) : super(key: key);
  final String name;
  final String quantity;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Text(
            'x' + quantity,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

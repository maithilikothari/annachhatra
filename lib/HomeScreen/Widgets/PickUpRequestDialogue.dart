import 'package:annachhatra/HomeScreen/Widgets/foodItems.dart';
import 'package:annachhatra/utils/ColorPallet.dart';
import 'package:flutter/material.dart';

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
    super.initState();
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
                    const SizedBox(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 30),
                      height: 200,
                      child: pickupRequest
                          ? const Center(
                              child: Text(
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
                              shape: const StadiumBorder(),
                              child: const Text('Done'),
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
                              shape: const StadiumBorder(),
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              textColor: ColorPallet().accentColor,
                            ),
                            MaterialButton(
                              elevation: 4,
                              color: ColorPallet().accentColor,
                              shape: const StadiumBorder(),
                              child: const Text('Pick Up'),
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

import 'package:flutter/material.dart';

import '../../utils/ColorPallet.dart';
import 'PickUpRequestDialogue.dart';

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

    // set up the AlertDialog

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const PickUpRequestDialogue();
      },
    );
  }
}

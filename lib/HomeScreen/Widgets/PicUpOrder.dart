import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PickUPOrder extends StatefulWidget {
  @override
  State<PickUPOrder> createState() => _PickUPOrderState();
}

class _PickUPOrderState extends State<PickUPOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Pick Up Order'),
      ),
      body: Container(
        child: ListViewBuilder(),
      ),
    );
  }
}

class ListViewBuilder extends StatelessWidget {
  const ListViewBuilder({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Material(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        elevation: 8,
        child: Container(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              AppBar().preferredSize.height * 10,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            color: Colors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.only(top: 40, left: 10, right: 20),
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      color: Colors.lightGreen.shade200),
                  child: Column(children: const [
                    (Text(
                      'Quantity',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '2',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 20),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Paneer Masala',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                      Text(
                                        '2',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Chicken Kebab',
                                        style:
                                            TextStyle(color: Colors.deepOrange),
                                      ),
                                      Text(
                                        '10',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '9.30pm,Today',
                                style: TextStyle(
                                    fontSize: 13, fontStyle: FontStyle.italic),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  decoration: BoxDecoration(),
                                  height: 25,
                                  child: RawMaterialButton(
                                    shape: StadiumBorder(),
                                    fillColor: Colors.red,
                                    onPressed: () {},
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

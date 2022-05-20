import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ViewDonation extends StatefulWidget {
  @override
  State<ViewDonation> createState() => _ViewDonationState();
}

class _ViewDonationState extends State<ViewDonation> {
  List<String> names = ['Vishal', 'Ujwala', 'Prachi', 'Pooja', 'Komal'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('View Donation'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: names.length,
            itemBuilder: (context, index) {
              return Text(names[index]);
            }),
      ),
    );
  }
}

class DonationItemTab extends StatelessWidget {
  const DonationItemTab({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                      borderRadius: BorderRadius.only(
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
                flex: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Paneer Masala',
                          style: TextStyle(color: Colors.green),
                        ),
                        SizedBox(
                          width: 40,
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
                    SizedBox(
                      height: 17,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Chicken Kebab',
                          style: TextStyle(color: Colors.deepOrange),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Text(
                          '10',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 70),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

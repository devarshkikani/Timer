import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'details.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? currentTime;
  String? deliveryTime;
  void bookinTime() async {
    DateTime now = DateTime.now();
    String _currentTime = DateFormat('hh:mm:ss').format(now);
    String _deliveryTime =
        DateFormat('hh:mm:ss').format(now.add(Duration(hours: 8)));
    setState(() {
      this.currentTime = _currentTime;
      this.deliveryTime = _deliveryTime;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("OrderTime", this.currentTime!);
    pref.setString("DeliveryTime", this.deliveryTime!);
  }

  @override
  initState() {
    super.initState();
    getTime();
  }

  getTime() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      currentTime = pref.getString("OrderTime") ?? null;
      deliveryTime = pref.getString("DeliveryTime") ?? null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              elevation: 50,
              shadowColor: Colors.black,
              color: Colors.greenAccent[100],
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://www.dhresource.com/0x0/f2/albu/g8/M01/11/7B/rBVaVF1vuiSAD0UPAAHJWlMfCtQ515.jpg/welcoming-pine-bonsai-simulation-artificial.jpg"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ), //SizedBox
                      Text(
                        'BONSAI TREE',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.green[900],
                          fontWeight: FontWeight.w500,
                        ), //Textstyle
                      ), //Text
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '₹8999    ⭐⭐⭐⭐⭐',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              bookinTime();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Buy',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          // if (currentTime != null)
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Details()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Details',
                              ),
                            ),
                          )
                          // else
                          //   Container(),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      if (currentTime != null)
                        Text("You buy at : $currentTime")
                      else
                        Container(),
                      SizedBox(
                        height: 5,
                      ),
                      if (deliveryTime != null)
                        Text("Youre order deliver at : $deliveryTime")
                      else
                        Container(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

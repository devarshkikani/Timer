import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  var orderHours, orderMinutes, orderSeconds;
  var deliveryHours, deliveryMinutes, deliverySeconds;
  @override
  initState() {
    super.initState();
    getOrderTime();
    getDeliveryTime();
  }

  getOrderTime() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? orderTime = pref.getString("OrderTime");
    var parts = orderTime!.split(':');
    var trimOrderHours = parts[0].trim();
    var trimOrderMinutes = parts[1].trim();
    var trimOrderSeconds = parts[2].trim();
    DateTime now = DateTime.now();
    String currentTime = DateFormat(' hh : mm : ss').format(now);
    var part = currentTime.split(':');
    var currentHours = part[0].trim();
    var currentMin = part[1].trim();
    var currentSec = part[2].trim();
    orderHours =
        (((int.parse(currentHours) - int.parse(trimOrderHours)) / 60) % 60)
            .floor()
            .toString()
            .padLeft(2, '0');
    orderMinutes = ((int.parse(currentMin) - int.parse(trimOrderMinutes)) % 60)
        .floor()
        .toString()
        .padLeft(2, '0');
    orderSeconds = ((int.parse(currentSec) - int.parse(trimOrderSeconds)) % 60)
        .floor()
        .toString()
        .padLeft(2, '0');
    setState(() {});
    // print("$deferenceHour : $deferenceMin : $deferenceSec");
    // print(orderTimeSave);
    // print(currentTime);
  }

  getDeliveryTime() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? orderTime = pref.getString("DeliveryTime");
    var parts = orderTime!.split(':');
    var trimDeliveryhours = parts[0].trim();
    var trimDeliveryMin = parts[1].trim();
    var trimDeliverySec = parts[2].trim();
    DateTime now = DateTime.now();
    String currentTime = DateFormat(' hh : mm : ss').format(now);
    var part = currentTime.split(':');
    var currentHours = part[0].trim();
    var currentMin = part[1].trim();
    var currentSec = part[2].trim();
    deliveryHours =
        (((int.parse(trimDeliveryhours) - int.parse(currentHours)) / (24 * 24))% 24)
            .floor()
            .toString()
            .padLeft(2, '0');
    //  var hours = ((newTick / (60 * 60)) % 60).floor()
    //   .toString()
    //   .padLeft(2, '0');
    deliveryMinutes =
        ((int.parse(trimDeliveryMin) - int.parse(currentMin)) % 60)
            .floor()
            .toString()
            .padLeft(2, '0');
    deliverySeconds =
        (int.parse(trimDeliverySec) - (int.parse(currentSec)) % 60)
            .floor()
            .toString()
            .padLeft(2, '0');
    setState(() {});
    // print("$deferenceHour : $deferenceMin : $deferenceSec");
    // print(orderTimeSave);
    // print(currentTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded)),
        title: Text("Details"),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://www.dhresource.com/0x0/f2/albu/g8/M01/11/7B/rBVaVF1vuiSAD0UPAAHJWlMfCtQ515.jpg/welcoming-pine-bonsai-simulation-artificial.jpg"),
              ),
            ),
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
              child: new Container(
                decoration:
                    new BoxDecoration(color: Colors.black.withOpacity(0.7)),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Center(
                      child: Text(
                    "$orderHours : $orderMinutes : $orderSeconds",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  )),
                  Center(
                      child: Text(
                    "Since you bought the item",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  )),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                      child: Text(
                    "Your order will arrive in",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  )),
                  Center(
                      child: Text(
                    "$deliveryHours : $deliveryMinutes : $deliverySeconds",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  )),
                  // Spacer(),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Back"))
            ],
          ),
        ],
      ),
    );
  }
}

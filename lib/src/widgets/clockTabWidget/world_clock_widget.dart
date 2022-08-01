import 'dart:isolate';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapptime/src/services/worldtime.dart';
import 'package:myapptime/src/widgets/clockTabWidget/choose_location.dart';

class WorldClock extends StatefulWidget {
  const WorldClock({Key? key}) : super(key: key);

  @override
  _WorldClockState createState() => _WorldClockState();
}

class _WorldClockState extends State<WorldClock> {
  String? location;
  String? flag;
  String? time;
  bool isDayTime = true;
  bool isloading = true;
  String? bgImage;
  Color? bgColor;
  void setupWordTime() async {
    WorldTime instance =
        WorldTime('Phnom Penh', 'Cambodia.png', 'Asia/Phnom_Penh');
    // we should put await function front of instence.getData() because it should be waiting before the getData done.
    await instance.getData();
    location = instance.location;
    flag = instance.flag;
    time = instance.time;
    bgImage = isDayTime ? 'day.jpg' : 'night.jpg';
    bgColor = isDayTime ? Colors.blue : Colors.indigo[700];

    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupWordTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: isloading ? loadingWidget : worldtime,
    );
  }

  Widget get loadingWidget {
    return Center(child: CircularProgressIndicator());
  }

  Widget get worldtime {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/${bgImage}'),
          fit: BoxFit.cover,
        )),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
          child: Column(
            children: <Widget>[
              FlatButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Choose_location()));
                    setState(() {
                      time = result['time'];
                      location = result['location'];
                      bgImage = result['isDaytime'] ? 'day.jpg' : 'night.jpg';
                      bgColor = result['isDaytime']
                          ? Colors.blue
                          : Colors.indigo[700];
                      flag = result['flag'];
                    });
                  },
                  icon: Icon(Icons.edit_location, color: Colors.grey[300]),
                  label: Text('Change Location',
                      style: TextStyle(color: Colors.grey[300]))),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${location}',
                    style: TextStyle(
                      fontSize: 28.0,
                      letterSpacing: 2.0,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                '${time}',
                style: TextStyle(
                  fontSize: 60.0,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
 
}

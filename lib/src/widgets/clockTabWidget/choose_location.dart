import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:myapptime/src/services/worldtime.dart';

class Choose_location extends StatefulWidget {
  @override
  _Choose_locationState createState() => _Choose_locationState();
}

class _Choose_locationState extends State<Choose_location> {
  List<WorldTime> locations = [
    WorldTime('London','uk.png','Europe/London',),
    WorldTime('Athens','greece.png','Europe/Berlin'),
    WorldTime('Cairo', 'egypt.png','Africa/Cairo'),
    WorldTime( 'Nairobi','kenya.png','Africa/Nairobi'),
    WorldTime('Chicago','usa.png','America/Chicago'),
    WorldTime('New York','usa.png','America/New_York'),
    WorldTime('Seoul','south_korea.png','Asia/Seoul'),
    WorldTime('Jakarta','indonesia.png','Asia/Jakarta'),
    WorldTime('Phnom Penh', 'Cambodia.png','Asia/Phnom_Penh'),
  ];
  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getData();
    Navigator.pop(context, {
      'location': instance.location,
      'time': instance.time,
      'flag': instance.flag,
      'isDaytime': instance.isDaytime,
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build function is runned');
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Choose a location'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body:ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () => updateTime(index),
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/${locations[index].flag}'),
                ),
              ),
            ),
          );
        },
      )
    );
  }
}

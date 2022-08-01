import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:intl/intl.dart';

class WorldTime {
  late String location; //location name for the UI
  late String time; //the time for location
  late String flag; // url to an assets icons
  late String string_url;
  late bool isDaytime = false; //true or false if daytime or not

  //WorldTime(this.location, this.time, this.flag, this.string_url);
  WorldTime(String location, String flag, String string_url){
    this.location =location;
    this.flag = flag;
    this.string_url = string_url;
  }
//Future function is kind of promise in javascript.
  Future<void> getData() async {
    try{
      var url = Uri.parse('http://worldtimeapi.org/api/timezone/$string_url');
      var  response = await http.get(url);
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      //get properties of data
      String datetime = jsonResponse['datetime'];
      String offset = jsonResponse['utc_offset'].substring(1,3);
      //print(datetime);
      //print(offset);
      //create datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      //print('this is time in pp ${now}');

      //set time property
      //this is a ternary Operator statement
      //isDaytime = condition ? true : false;
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);

    }catch(e){
      print('caught error: ${e.toString()}');
      time = 'could not get time data';
    }
  }
}

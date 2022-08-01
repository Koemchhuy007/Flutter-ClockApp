import 'package:flutter/material.dart';
import 'package:myapptime/src/widgets/clockTabWidget/world_clock_widget.dart';
import 'package:myapptime/src/widgets/timerTabWidget/timer_widget.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int navbarIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:body,
      bottomNavigationBar:bottomNavigationBar,
    );
  }

  Widget get body{
    if(navbarIndex == 0){
      return WorldClock();
    }else{
      return TimerWidget();
    }
  }

  Widget get bottomNavigationBar{

    return BottomNavigationBar(
      onTap: (value){
        setState((){
          navbarIndex = value;
        });
      },
        currentIndex: navbarIndex,
        type: BottomNavigationBarType.fixed,
        items: [
      BottomNavigationBarItem(icon: Icon(Icons.av_timer), label: 'Clock'),
      BottomNavigationBarItem(icon: Icon(Icons.time_to_leave_rounded), label: 'Timer'),
    ]);
  }

}

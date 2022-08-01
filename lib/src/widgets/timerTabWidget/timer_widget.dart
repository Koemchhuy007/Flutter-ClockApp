import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapptime/main.dart';
class TimerWidget extends StatefulWidget {
  const TimerWidget({ Key? key }) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
 Duration countUpDuration = Duration(minutes: 0);
  Duration duration = Duration();
  Timer? timer;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //startTimer();
    reset();
  }
  //reset time to 00
  void reset(){
       setState(()  => duration = countUpDuration);
  }
  //Increase by 1 seconds
  void addTime(){
    final addSeconds =  1 ;
    //final addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      //if time in 00 00 00
      if(seconds < 1){
        timer?.cancel();
      }else {
        duration = Duration(seconds: seconds);
      }
      duration = Duration(seconds: seconds);
    });
  }
  void startTimer({bool resets=true}){
    if(resets){
      reset();
    }
    //Starting loop of time
    timer= Timer.periodic(Duration(milliseconds: 1), (_) => addTime());
  }
  //Stop Timer
  void stopTimer({bool resets= true}){
    if(resets){
      reset();
    }
    setState(() => timer?.cancel());
  }

  //build Function get starting Widget
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: Center(child: buildTime()));
  }

  //BuildTime widget for Build Widget time.
  Widget buildTime(){
    String twoDigits(int n) => n.toString().padLeft(2,'0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final hours = twoDigits(duration.inHours);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
         
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildTimeCard(time: hours, header: 'HOURS'),
                const SizedBox(width: 8), 
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('HOURS',style: TextStyle(fontSize: 16)),
                )
              ],
            ),
            const SizedBox(width: 8), 
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildTimeCard(time: minutes, header: 'MINUTES', ),
                const SizedBox(width: 8), 
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('MINUTES',style: TextStyle(fontSize: 16)),
                )
              ],
            ),
            const SizedBox(width: 8),      
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildTimeCard(time: seconds, header: 'SECONDS'),
                const SizedBox(width: 8), 
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('SECONDS',style: TextStyle(fontSize: 16)),
                )
              ],
            ),
          ], 
        ),
         Padding(
           padding: const EdgeInsets.all(16.0),
           child: buildButton(),
         )
      ],
    );
  }
  //Card hours , minuts, and seconds
  Widget buildTimeCard({required String time, required String header}){
    return Container(
      padding:EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Text(
        time,
        style: TextStyle(
        fontWeight: FontWeight.bold,
        color:Colors.black,
        fontSize: 72,
        ),
      ),
      
    );
  }

  //BuildBotton
  Widget buildButton(){
    final isRunning = timer == null ? false : timer!.isActive;
    final isComplete = duration.inSeconds == 0;
    return isRunning || !isComplete ? Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RaisedButton(
          onPressed: (){
            if(isRunning){
              stopTimer(resets:false);
            }else{
            startTimer(resets:false);
            }
          },
          child: isRunning ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'STOP',
              style: TextStyle(fontSize: 24),
            ),
            
          ): Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('RESUME',style: TextStyle(fontSize: 24)),
          ),
        ),
        const SizedBox(width: 8),
        RaisedButton(
          onPressed: (){ stopTimer();},
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('CANCEL',style: TextStyle(fontSize: 24)),
          ),
        )
      ],
    ) : RaisedButton(
      onPressed: () async{
         startTimer();
         },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Start Timer',
          style: TextStyle(fontSize: 24)
        ),
      ),
    );
  }
}
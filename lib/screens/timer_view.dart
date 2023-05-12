import 'dart:async';

import 'package:count_down/model/count_down.dart';
import 'package:count_down/widgets/sizeBox.dart';
import 'package:flutter/material.dart';

class TimerView extends StatefulWidget {
  final TimerData data;
  const TimerView({Key? key, required this.data}) : super(key: key);

  @override
  State<TimerView> createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {
  int sec = 0;
  bool isRead = false;
  Timer? countdownTimer;
  Duration myDuration = Duration(seconds: 0);
  @override
  void initState() {
    super.initState();
  }
  startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }
  stopTimer() {
    setState(() => countdownTimer!.cancel());
  }
  resetTimer() {
    stopTimer();
    setState(() => myDuration = Duration(seconds: sec));
  }
  setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
        widget.data.status = 0;
        isRead = false;
      } else {
        myDuration = Duration(seconds: seconds);
        isRead = true;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    var hours = strDigits(myDuration.inHours.remainder(24));
    var  minutes = strDigits(myDuration.inMinutes.remainder(60));
    var seconds = strDigits(myDuration.inSeconds.remainder(60));
    return  Center(
        child: Column(
          children: [
            Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black)
                  ),
                  child: Center(
                    child: TextFormField(
                      readOnly: isRead,
                        controller: widget.data.count,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter count',
                        ),
                        textAlign: TextAlign.center,
                        onChanged: (v){
                          debugPrint("v is $v");
                        }
                    ),
                  ),
                ),
              ),
              widthSpace(width: 10),
              Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black)
                    ),
                    child: Center(child: Text('$hours:$minutes:$seconds')),
                  )
              ),
              widthSpace(width: 10),
              ElevatedButton(
                onPressed: (){
                  FocusManager.instance.primaryFocus?.unfocus();
                  if(widget.data.status == 0) {
                    widget.data.status = 1;
                    // setState(() {
                      debugPrint("text is ${widget.data.count.text}");
                      sec = int.parse(widget.data.count.text);
                    setState(() => myDuration = Duration(seconds: sec));
                      startTimer();
                    // });
                  }
                  else if(widget.data.status == 1){
                    widget.data.status = 2;
                    if (countdownTimer == null || countdownTimer!.isActive) {
                      stopTimer();
                    }
                  }else if(widget.data.status == 2){
                    widget.data.status = 1;
                    startTimer();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(widget.data.status == 1 ? "Pause" : widget.data.status == 2 ? "Resume" : "Start"),
                ),
              )
            ],
          ),
        )
          ],
        ),
      );
  }
}
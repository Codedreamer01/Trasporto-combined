import 'dart:async';

import 'package:flutter/material.dart';

import 'list_screen.dart';

class CountDown extends StatefulWidget {
  const CountDown({Key? key}) : super(key: key);

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  Timer? countdownTimer;
  DateTime now = DateTime.now();
  DateTime bustime = DateTime.parse("2022-07-30 23:50:00");

  //int second = 60;
  //int minute = 5;
  var txt;
  void _startCountDown() {
    Duration diff = bustime.difference(now);

    int timelefthrs = diff.inHours;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (diff.isNegative) {
        setState(() {
          timelefthrs--;
        });
      } else {
        timer.cancel();
      }
    });
    diff == 0 ? txt = 'DONE' : txt = diff.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Text(
              txt,
              style: const TextStyle(fontSize: 70),
            ),
            MaterialButton(
              onPressed: _startCountDown,
              color: Colors.cyan,
              child: const Text(
                'S T A R T',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ])),
    );
  }
}

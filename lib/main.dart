import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // int totalTime = 60;
  int times = 60;
  late Timer timer;
  String timeView = '0:00:00';
  bool isRunning = false;

  void timeStart() {
    if (isRunning) {
      timeStop();
      setState(() {
        isRunning = !isRunning;
      });
    } else {
      setState(() {
        isRunning = !isRunning;
      });
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          timeView = Duration(seconds: times).toString().split('.')[0];
          times--;
          if (times < 0) {
            timeStop();
            isRunning = !isRunning;
          }
        });
      });
    }
  }

  void timeStop() {
    timer.cancel();
  }

  void timeReset() {
    setState(() {
      timeStop();
      times = 60;
      isRunning = false;
      timeView = Duration(seconds: times).toString().split('.').first;
    });
  }

  void addTime(int sec) {
    times += sec;
    times = times < 0 ? 0 : times;
    setState(() {
      timeView = Duration(seconds: times).toString().split('.').first;
    });
  }

  @override
  Widget build(BuildContext context) {
    timeView = Duration(seconds: times).toString().split('.').first;
    return MaterialApp(
      home: Scaffold(
          body: Column(
        children: [
          Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black,
                child: const Center(
                  child: Text(
                    'my timer',
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                ),
              )),
          Flexible(
              flex: 1,
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    timeButton(sec: 60, color: Colors.amber),
                    timeButton(sec: 30, color: Colors.cyan),
                    timeButton(sec: -60, color: Colors.deepOrange),
                    timeButton(sec: -30, color: Colors.grey),
                  ],
                ),
              )),
          Flexible(
            flex: 2,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.blueAccent,
              child: Center(
                child: Text(
                  timeView,
                  style: const TextStyle(color: Colors.white, fontSize: 50),
                ),
              ),
            ),
          ),
          Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isRunning)
                        IconButton(
                            iconSize: 50,
                            onPressed: timeStart,
                            icon: Icon(Icons.pause_circle_rounded))
                      else
                        IconButton(
                            iconSize: 50,
                            onPressed: timeStart,
                            icon: const Icon(Icons.play_circle_rounded)),
                      SizedBox(
                        width: 20,
                      ),
                      IconButton(
                          iconSize: 50,
                          onPressed: timeReset,
                          icon: Icon(Icons.restore_rounded))
                    ],
                  ),
                ),
              ))
        ],
      )),
    );
  }

  GestureDetector timeButton({required int sec, required Color color}) {
    return GestureDetector(
      onTap: () => addTime(sec),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: Center(child: Text('$sec')),
      ),
    );
  }
}

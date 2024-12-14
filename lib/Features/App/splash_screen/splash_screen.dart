

import 'package:flutter/material.dart';

class splash_screen extends StatefulWidget {
  final Widget? child;

  const splash_screen(
      {super.key, this.child, required bool debugShowCheckedModeBanner});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
          context as BuildContext,
          MaterialPageRoute(builder: (context) => widget.child!),
              (route) => false);
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Welcome',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.lightGreen,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'WasteWisePro',
                  style: TextStyle(
                      fontSize: 50,
                      color: Colors.lightGreen,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

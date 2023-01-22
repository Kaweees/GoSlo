import 'package:flutter/material.dart';

class Storepage extends StatefulWidget {
  const Storepage({Key? key}) : super(key: key);

  @override
  State<Storepage> createState() => _StorepageState();
}

class _StorepageState extends State<Storepage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(),
      ),
    );
  }
}

// Imports
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sloth/dashboard.dart';
import 'package:sloth/data.dart';
import 'package:sloth/onboarding.dart';
import 'package:sloth/wrapper.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splash(),
    );
  }
}

// Page
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future handleLoad() async {
    Future.delayed(const Duration(milliseconds: 3000)).then((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const OnBoardingPage(),
        ),
      );
    });
  }

  Future configDatabase() async {
    /*

    // Use an in-memory database
    final database = MemoryDatabaseAdapter().database();

    // Our collection
    final collection = database.collection('Quests');

    for (int x = 0; x < data; x++) {
    // Our document
    final document = collection.document(x.toString());

    await document.upsert(data: {
      "name": data[x]['name'],
      "distance": data[x]['distance'],
      "reward": data[x]['reward'],
      "quest_stops": data[x]['quest_stops']
    });
    }
    */
  }

  @override
  void initState() {
    handleLoad();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          decoration: const BoxDecoration(
            color: Color(0x00FFFFFF),
          ),
          child: Align(
              alignment: AlignmentDirectional(0, 0),
              child: Image.asset(
              'lib/assets/logo.png',
              width: MediaQuery.of(context).size.width * 0.5,
              fit: BoxFit.fitWidth,
            ),
            
                  ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sloth/choose_role_page.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(left: 40.0, right: 40.0),
          child: Column(
            children: [
              const Spacer(),
              const Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Text(
                  'Welcome',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Text(
                  'Ready to start your adventure around your town?',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Image.asset(
                'lib/assets/welcome.png',
                height: 250,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const ChooseRolePage(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green,
                    boxShadow: const [
                      BoxShadow(color: Colors.green, spreadRadius: 3),
                    ],
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 11, horizontal: 95),
                  child: const Text(
                    'Count me in!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Text(
                  'Welcome',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Text(
                  'Ready to start your adventure around town?',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Image.asset(
                'lib/assets/welcome.png',
                height: 250,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: const EdgeInsets.only(top: 10, bottom: 25),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        shadowColor: const Color.fromRGBO(21, 71, 52, 1),
                        backgroundColor: const Color.fromRGBO(21, 71, 52, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const ChooseRolePage()));
                      },
                      child: Container(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          margin: const EdgeInsets.only(top: 13, bottom: 13),
                          child: const Text(
                            "Count me in!",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))),
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

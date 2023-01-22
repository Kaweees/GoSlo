import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sloth/wrapper.dart';

class ChooseRolePage extends StatefulWidget {
  const ChooseRolePage({super.key});

  @override
  State<ChooseRolePage> createState() => _ChooseRolePageState();
}

class _ChooseRolePageState extends State<ChooseRolePage> {
  var selected = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.2),
                  child: const Text(
                    "I am looking to...",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        margin: const EdgeInsets.only(top: 40),
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: selected == 0
                                    ? Color.fromRGBO(21, 71, 52, 1)
                                    : Colors.grey,
                                width: 4)),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selected = 0;
                            });
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Sight See ',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: selected == 0
                                          ? Color.fromRGBO(21, 71, 52, 1)
                                          : Colors.grey),
                                ),
                                Icon(Icons.visibility)
                              ]),
                        )),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        margin: EdgeInsets.only(top: 20),
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: selected == 1
                                    ? Color.fromRGBO(21, 71, 52, 1)
                                    : Colors.grey,
                                width: 4)),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selected = 1;
                            });
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Shop Around',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: selected == 1
                                          ? Color.fromRGBO(21, 71, 52, 1)
                                          : Colors.grey),
                                ),
                                Icon(Icons.store)
                              ]),
                        )),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        margin: const EdgeInsets.only(top: 20),
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: selected == 2
                                    ? Color.fromRGBO(21, 71, 52, 1)
                                    : Colors.grey,
                                width: 4)),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selected = 2;
                            });
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Meet New People ',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: selected == 2
                                          ? Color.fromRGBO(21, 71, 52, 1)
                                          : Colors.grey),
                                ),
                                Icon(Icons.people)
                              ]),
                        )),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        margin: const EdgeInsets.only(top: 20),
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: selected == 3
                                    ? Color.fromRGBO(21, 71, 52, 1)
                                    : Colors.grey,
                                width: 4)),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selected = 3;
                            });
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Just Explore ',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: selected == 3
                                          ? Color.fromRGBO(21, 71, 52, 1)
                                          : Colors.grey),
                                ),
                                Icon(Icons.remove_red_eye)
                              ]),
                        )),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: const EdgeInsets.only(top: 30),
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
                                  builder: (context) => const Wrapper()));
                        },
                        child: Container(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            margin: const EdgeInsets.only(top: 13, bottom: 13),
                            child: const Text(
                              "Let's go",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}

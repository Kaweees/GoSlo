import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sloth/ai.dart';
import 'package:sloth/data.dart';
import 'package:sloth/quest_stops.dart';

class Quests extends StatefulWidget {
  const Quests({Key? key}) : super(key: key);

  @override
  State<Quests> createState() => _QuestsState();
}

class _QuestsState extends State<Quests> {
  int coins = Data.coins;
  List quests = [];

  Future update() async {
    // Get Quests
    quests = [];
    for (int x = 0; x < Data.data["quests"].length; x++) {
      quests.add(Data.data["quests"][x]);
    }

    //AiModel().main();
    setState(() {
      coins = Data.coins;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    update();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 0, left: 30),
                              child: Text(
                                "Quests",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 10),
                              child: IconButton(
                                  onPressed: () {
                                    update();
                                  },
                                  icon: const Icon(Icons.refresh)),
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 30),
                          child: Row(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Text(
                                    Data.coins.toString(),
                                    style: TextStyle(
                                        color: Colors.yellow[700],
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Icon(
                                  Icons.monetization_on_outlined,
                                  color: Colors.yellow[700],
                                  size: 30,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0, left: 30),
                      child: Text(
                        quests.length.toString() + " Quests",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: quests.length,
                        itemBuilder: ((context, index) {
                          double percent = 0.0;
                          int completed = 0;
                          int total = quests[index]["quest_stops"].length;

                          for (int x = 0;
                              x < quests[index]["quest_stops"].length;
                              x++) {
                            if (quests[index]["quest_stops"][x]["completed"] ==
                                true) {
                              completed += 1;
                            }
                          }

                          percent =
                              double.parse((completed / total).toString());
                          return Container(
                            margin: const EdgeInsets.only(
                              top: 20,
                              left: 20,
                              right: 20,
                            ),
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 7,
                                  color: Color(0x53000000),
                                  offset: Offset(0, 2),
                                )
                              ],
                              border: Border.all(
                                width: 2,
                                color: const Color.fromRGBO(21, 71, 52, 1),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 75,
                                  width: 75,
                                  margin: const EdgeInsets.only(left: 15),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                        fit: BoxFit.cover,
                                        "https://www.slocity.org/home/showpublishedimage/18503/637992694344400000"),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                quests[index]["name"],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 5),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 110,
                                                      child: Container(
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(10),
                                                          ),
                                                          child:
                                                              LinearProgressIndicator(
                                                            minHeight: 5,
                                                            value: percent,
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              const Color
                                                                      .fromRGBO(
                                                                  21,
                                                                  71,
                                                                  52,
                                                                  1),
                                                            ),
                                                            backgroundColor:
                                                                Color(
                                                                    0xffD6D6D6),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        left: 15,
                                                      ), //apply padding to all four sides
                                                      child: Text(
                                                        (percent * 100)
                                                                .toStringAsFixed(
                                                                    1) +
                                                            "%",
                                                        style: TextStyle(
                                                          color: Colors.black87,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

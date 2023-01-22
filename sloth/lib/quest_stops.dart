import 'dart:async';

import 'package:animated_checkmark/animated_checkmark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:sloth/data.dart';

class QuestStops extends StatefulWidget {
  const QuestStops({Key? key}) : super(key: key);

  @override
  State<QuestStops> createState() => _QuestStopsState();
}

class _QuestStopsState extends State<QuestStops> {
  int totalStops = 0;
  int stopsCompleted = 0;
  int _index = 0;
  int current_index = 0;
  bool animateCheck = false;
  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  String? code;

  List<Step> steps = [];
  var quest_stops = Data.data['quests'][0]["quest_stops"];

  Future loadSteps() async {
    totalStops = 0;
    stopsCompleted = 0;
    _index = 0;
    current_index = 0;
    animateCheck = false;
    code = "";

    steps = [];
    quest_stops = Data.data['quests'][0]["quest_stops"];

    _index = 0;

    quest_stops = Data.data['quests'][0]["quest_stops"];
    for (int x = 0; x < quest_stops.length; x++) {
      totalStops += 1;

      if (quest_stops[x]['completed']) {
        stopsCompleted += 1;
        _index += 1;
      }
      steps.add(Step(
        isActive: quest_stops[x]['completed'],
        title: Text(quest_stops[x]["location_name"].toString()),
        content: Container(
            alignment: Alignment.centerLeft,
            child: Text('Scan the QR code given by ' +
                quest_stops[x]["location_name"].toString())),
      ));
    }
    //final database = base.MemoryDatabaseAdapter().database();

    //final snapshot = await database.collection("Quests").document("0").get();

// Use 'exists' to check whether the document exists
    //if (snapshot.exists) {
    //var quest_stops = snapshot.data["quest_stops"];

    /*
      if (quest_stops != null) {
        print(quest_stops);
        
      for (int x = 0; x < quest_stops.length; x++) {
        print(x);
        print(_index);
        steps.add(Step(
          isActive: _index > x,
          title: Text(quest_stops[x]["location_name"].toString()),
          content: Container(
              alignment: Alignment.centerLeft,
              child: Text('Scan the QR code given by ' +
                  quest_stops[x]["location_name"].toString())),
        ));
        
      }

      }

      */

    //}

    setState(() {});
  }

  @override
  void initState() {
    loadSteps();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 0, left: 25),
                      child: const Text(
                        "Quest Stops",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5, left: 25),
                      child: Text(
                        (totalStops - stopsCompleted).toString() +
                            " Stops remaining",
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    _index < steps.length
                        ? Container(
                            padding: const EdgeInsets.only(top: 7),
                            child: steps.isNotEmpty
                                ? Stepper(
                                    physics: const BouncingScrollPhysics(),
                                    currentStep: _index,
                                    controlsBuilder: (BuildContext context,
                                        ControlsDetails details) {
                                      return Row(
                                        children: <Widget>[
                                          TextButton(
                                            onPressed: details.onStepContinue,
                                            child: const Text('Scan QR'),
                                          ),
                                        ],
                                      );
                                    },
                                    onStepCancel: () {},
                                    onStepContinue: () async {
                                      String barcodeScanRes =
                                          await FlutterBarcodeScanner
                                                  .scanBarcode(
                                                      "#154734",
                                                      "Cancel",
                                                      false,
                                                      ScanMode.QR)
                                              .then((code) {
                                        try {
                                          if (code ==
                                              quest_stops[_index]
                                                  ["auth_code"]) {
                                            if (_index >= 0 &&
                                                _index < steps.length) {
                                              // Updates
                                              Data.data["quests"][0]
                                                      ["quest_stops"][_index]
                                                  ["completed"] = true;

                                              /*

                                              showDialog<void>(
                                                context: context,
                                                barrierDismissible:
                                                    false, // user must tap button!
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Activity Completed!'),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: ListBody(
                                                        children: const <
                                                            Widget>[
                                                          Text(
                                                              'Get the other ones done.'),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: const Text('Ok'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ); */

                                              loadSteps();

                                              //loadSteps();
                                            }
                                          } else {
                                            showDialog<void>(
                                              context: context,
                                              barrierDismissible:
                                                  false, // user must tap button!
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Invalid Code!'),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: ListBody(
                                                      children: const <Widget>[
                                                        Text(
                                                            'The code you scanned was invalid. Please try again.'),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: const Text(
                                                          'Try again'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        } catch (e) {
                                          showDialog<void>(
                                            context: context,
                                            barrierDismissible:
                                                false, // user must tap button!
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title:
                                                    const Text('Invalid Code!'),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: const <Widget>[
                                                      Text(
                                                          'The code you scanned was invalid. Please try again.'),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child:
                                                        const Text('Try again'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }

                                        return "";
                                      });

                                      /*
                                      _qrBarCodeScannerDialogPlugin
                                          .getScannedQrBarCode(
                                              context: context,
                                              onCode: (code) {
                                                
                                              });
                                              */
                                    },
                                    onStepTapped: (int index) {},
                                    steps: steps,
                                  )
                                : const SizedBox())
                        : Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.3),
                            child: Center(
                              child: Column(
                                children: [
                                  AnimatedCheckmark(
                                    active: true,
                                    weight: 12,
                                    size: Size.square(90),
                                    color: Colors.green,
                                    style: CheckmarkStyle.round,
                                    duration: Duration(seconds: 1),
                                  ),
                                  Container(
                                    child: const Text(
                                      "Quest Finished!",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ])),
        ),
      ),
    );
  }
}

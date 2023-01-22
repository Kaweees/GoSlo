import 'package:animated_checkmark/animated_checkmark.dart';
import 'package:flutter/material.dart';

class QuestStops extends StatefulWidget {
  const QuestStops({super.key});

  @override
  State<QuestStops> createState() => _QuestStopsState();
}

class _QuestStopsState extends State<QuestStops> {
  int totalStops = 10;
  int stopsCompleted = 3;
  int _index = 0;
  bool animateCheck = false;

  List quest_stops = [
    {
      "location_name": "Hearst Castle",
      "auth_code": "Random Text",
      "description":
          "Visit the famous Hearst Castle, a historic mansion and National Historic Landmark that offers tours of the property and its gardens.",
      "coordinates": {"longitude": 121.58, "latitude": 35.67},
      "completed": false
    },
    {
      "location_name": "Big Sky Cafe",
      "auth_code": "abc123",
      "description": "A popular breakfast spot in San Luis Obispo",
      "coordinates": {"longitude": -120.6596156, "latitude": 35.2827524},
      "completed": false
    },
    {
      "location_name": "Thomas Hill Organics",
      "auth_code": "def456",
      "description":
          "Farm-to-table restaurant with a focus on local, organic ingredients",
      "coordinates": {"longitude": -120.6625, "latitude": 35.2812},
      "completed": false
    },
    {
      "location_name": "Novo",
      "auth_code": "ghi789",
      "description": "Contemporary Mediterranean and California cuisine",
      "coordinates": {"longitude": -120.6645, "latitude": 35.2815},
      "completed": false
    },
    {
      "location_name": "Sci-Fi Pizza",
      "auth_code": "jkl012",
      "description": "Pizza restaurant with a science fiction theme",
      "coordinates": {"longitude": -120.66, "latitude": 35.28},
      "completed": false
    },
    {
      "location_name": "Blacksmiths Kitchen",
      "auth_code": "mno345",
      "description":
          "Rustic American cuisine with a focus on seasonal ingredients",
      "coordinates": {"longitude": -120.6655, "latitude": 35.2825},
      "completed": false
    },
    {
      "location_name": "Mother's Tavern",
      "auth_code": "pqr678",
      "description": "A casual spot for burgers, sandwiches, and beer",
      "coordinates": {"longitude": -120.66, "latitude": 35.2795},
      "completed": false
    },
    {
      "location_name": "Taco Temple",
      "auth_code": "stu901",
      "description":
          "Taco restaurant with a variety of unique and flavorful fillings",
      "coordinates": {"longitude": -120.6625, "latitude": 35.2775},
      "completed": false
    },
    {
      "location_name": "The Spoon Room",
      "auth_code": "vwx234",
      "description": "Contemporary American cuisine with a focus on seafood",
      "coordinates": {"longitude": -120.6675, "latitude": 35.2820},
      "completed": false
    },
    {
      "location_name": "The Station",
      "auth_code": "zyx567",
      "description": "A cozy spot for coffee, tea, and pastries",
      "coordinates": {"longitude": -120.6635, "latitude": 35.2810},
      "completed": false
    }
  ];

  List<Step> steps = [];

  Future loadSteps() async {
    steps = [];
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
                    _index < steps.length - 1
                        ? Container(
                            padding: const EdgeInsets.only(top: 7),
                            child: steps.isNotEmpty
                                ? Stepper(
                                    physics: const BouncingScrollPhysics(),
                                    currentStep: _index,
                                    onStepCancel: () {
                                      if (_index > 0) {
                                        setState(() {
                                          _index -= 1;
                                        });
                                      }
                                    },
                                    onStepContinue: () {
                                      print(_index);
                                      print(steps.length);
                                      if (_index >= 0 &&
                                          _index < steps.length) {
                                        setState(() {
                                          _index += 1;
                                          Future.delayed(Duration(seconds: 1))
                                              .then((value) {
                                            animateCheck = true;
                                          });
                                        });
                                        loadSteps();
                                      }
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
                                    active: animateCheck,
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

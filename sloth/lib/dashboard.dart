import 'dart:async';

import 'package:another_stepper/another_stepper.dart';
import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sloth/quest_stops.dart';
import 'package:sloth/quests.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool questStarted = false;
  double maxChildSize = 0.30;

  var _index = 0;
  List quests = [
    {
      "name": "San Luis Obispo Sight Seeing Quest",
      "distance": 6.3,
      "reward": 100
    }
  ];
  var currentQuest = {
    "name": "San Luis Obispo Sight Seeing Quest",
    "distance": 6.3,
    "reward": 100
  };

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

  Map<MarkerId, Marker> quest_markers = <MarkerId, Marker>{};

  Future plotCoordinates() async {
    for (int x = 0; x < quest_stops.length; x++) {
      var marker = Marker(
          markerId: MarkerId(quest_stops[x]["auth_code"]),
          position: LatLng(quest_stops[x]["coordinates"]['latitude'],
              quest_stops[x]["coordinates"]['longitude']));

      quest_markers[MarkerId(quest_stops[x]["auth_code"])] = marker;
    }
    setState(() {});
  }

  @override
  void initState() {
    currentQuest = quests[0];
    setPermissions().then((value) {
      initialSetup();
    });
    super.initState();
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  CameraPosition initialPos = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Future setPermissions() async {
    var status = await Permission.location.status;
    var status1 = await Permission.locationAlways.status;
    var status2 = await Permission.locationWhenInUse.status;
    var status3 = await Permission.camera.status;

    print("HERE: ++++++++++++++++++++++++++ : " + status.toString());

    if (status.isGranted &&
        status1.isGranted &&
        status2.isGranted &&
        status3.isGranted) {
      print("All permissions granted");
    } else {
      print("REQUESTING::: ++++");
      await Permission.location.request();
      await Permission.locationAlways.request();
      await Permission.camera.request();
    }
  }

  Future initialSetup() async {
    var location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    changeCameraPosition(location.latitude, location.longitude);

    print("Latitude: " + location.latitude.toString());

    plotCoordinates();
  }

  Future<void> changeCameraPosition(lat, lng) async {
    var loc = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 14.4746,
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(loc));
  }

  List<StepperData> stepperData = [
    StepperData(
      title: StepperText("Delivered",
          textStyle: const TextStyle(
            color: Colors.grey,
          )),
    ),
    StepperData(
      title: StepperText("Delivered",
          textStyle: const TextStyle(
            color: Colors.grey,
          )),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        /*
        bottomSheet: BottomSheet(
          onClosing: () {},
          enableDrag: false,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return Container();
          },
        ),
        */
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              buildingsEnabled: true,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              trafficEnabled: true,
              initialCameraPosition: initialPos,
              markers: quest_markers.values.toSet(),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.38,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.white),
                  child: questStarted == false
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 15),
                                  child: Text(
                                    "Start Quest",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 20, left: 20, right: 20),
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
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
                                          color: const Color.fromRGBO(
                                              21, 71, 52, 1))),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 75,
                                        width: 75,
                                        margin: const EdgeInsets.only(left: 15),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                              fit: BoxFit.cover,
                                              "https://www.slocity.org/home/showpublishedimage/18503/637992694344400000"),
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
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
                                                      currentQuest["name"]
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 20),
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 5),
                                                      child: Text(
                                                        currentQuest["distance"]
                                                                .toString() +
                                                            " Mi - " +
                                                            currentQuest[
                                                                    "reward"]
                                                                .toString() +
                                                            " Coins",
                                                        style: TextStyle(
                                                            color: Colors.grey),
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
                                ),
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 25),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    shadowColor:
                                        const Color.fromRGBO(21, 71, 52, 1),
                                    backgroundColor:
                                        const Color.fromRGBO(21, 71, 52, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      questStarted = true;
                                    });
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 5),
                                      margin: const EdgeInsets.only(
                                          top: 13, bottom: 13),
                                      child: const Text(
                                        "Start Quest!",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ))),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Text(
                                      currentQuest["name"].toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    currentQuest["distance"].toString() +
                                        " Miles Total",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 20),
                                child: LinearProgressIndicator(
                                  color: const Color.fromRGBO(21, 71, 52, 1),
                                  backgroundColor: Colors.grey,
                                  value: 0.7,
                                  minHeight: 8,
                                )),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              margin: const EdgeInsets.only(top: 10, bottom: 0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    shadowColor: Colors.grey,
                                    backgroundColor: Colors.grey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                const QuestStops()));
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 5),
                                      margin: const EdgeInsets.only(
                                          top: 13, bottom: 13),
                                      child: const Text(
                                        "View Stops",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ))),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              margin: const EdgeInsets.only(top: 5, bottom: 25),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    shadowColor: Colors.red,
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      questStarted = false;
                                    });
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 5),
                                      margin: const EdgeInsets.only(
                                          top: 13, bottom: 13),
                                      child: const Text(
                                        "Stop Quest",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ))),
                            ),
                          ],
                        ),
                )),

            /*
            DraggableScrollableSheet(
              initialChildSize: 0.30,
              minChildSize: 0.30,
              expand: true,
              maxChildSize: 0.6,
              snap: true,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  controller: scrollController,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x53000000),
                              offset: Offset(0, 2),
                            )
                          ]),
                      child: questStarted == false
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 15),
                                      child: Text(
                                        "Start Quest",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 20, left: 20, right: 20),
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                              color: const Color.fromRGBO(
                                                  21, 71, 52, 1))),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 75,
                                            width: 75,
                                            margin:
                                                const EdgeInsets.only(left: 15),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                  fit: BoxFit.cover,
                                                  "https://www.slocity.org/home/showpublishedimage/18503/637992694344400000"),
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.6,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          currentQuest["name"]
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 20),
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(top: 5),
                                                          child: Text(
                                                            currentQuest[
                                                                        "distance"]
                                                                    .toString() +
                                                                " Mi - " +
                                                                currentQuest[
                                                                        "reward"]
                                                                    .toString() +
                                                                " Coins",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey),
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
                                    ),
                                  ],
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 25),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 10,
                                        shadowColor:
                                            const Color.fromRGBO(21, 71, 52, 1),
                                        backgroundColor:
                                            const Color.fromRGBO(21, 71, 52, 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          questStarted = true;
                                          maxChildSize = 0.8;
                                        });
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          margin: const EdgeInsets.only(
                                              top: 13, bottom: 13),
                                          child: const Text(
                                            "Start Quest!",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ))),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Column(
                                    children: [
                                      Text(
                                        currentQuest['name'].toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 7),
                                  child: Text(
                                    currentQuest['distance'].toString() +
                                        " miles total",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 7),
                                    child: Stepper(
                                      currentStep: _index,
                                      onStepCancel: () {
                                        if (_index > 0) {
                                          setState(() {
                                            _index -= 1;
                                          });
                                        }
                                      },
                                      onStepContinue: () {
                                        if (_index <= 0) {
                                          setState(() {
                                            _index += 1;
                                          });
                                        }
                                      },
                                      onStepTapped: (int index) {
                                        setState(() {
                                          _index = index;
                                        });
                                      },
                                      steps: <Step>[
                                        Step(
                                          isActive: _index == 0,
                                          title: const Text('Step 1 title'),
                                          content: Container(
                                              alignment: Alignment.centerLeft,
                                              child: const Text(
                                                  'Scan the QR code given by the shop')),
                                        ),
                                        Step(
                                          isActive: _index == 1,
                                          title: const Text('Step 1 title'),
                                          content: Container(
                                              alignment: Alignment.centerLeft,
                                              child: const Text(
                                                  'Content for Step 1')),
                                        )
                                      ],
                                      
                                    )),
                              ],
                            ),
                            
                            
                    )
                  ]),
                );
              },
            ),
            */
          ],
        ),
      ),
    );
  }
}

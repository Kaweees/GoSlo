import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    // TODO: implement initState
    setPermissions().then((value) {
      initialSetup();
    });
    super.initState();
  }

  Map<MarkerId, Marker> hermeMarkers = <MarkerId, Marker>{};
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  CameraPosition initialPos = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Future setPermissions() async {
    var status = await Permission.location.status;
    var status1 = await Permission.locationAlways.status;
    var status2 = await Permission.locationWhenInUse.status;

    print("HERE: ++++++++++++++++++++++++++ : " + status.toString());

    if (status.isGranted && status1.isGranted && status2.isGranted) {
      print("All permissions granted");
    } else {
      print("REQUESTING::: ++++");
      var s = await Permission.location.request();
      var s1 = await Permission.locationAlways.request();
    }
  }

  Future initialSetup() async {
    var location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    changeCameraPosition(location.latitude, location.longitude);

    print("Latitude: " + location.latitude.toString());
  }

  Future<void> changeCameraPosition(lat, lng) async {
    var loc = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 14.4746,
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(loc));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomSheet: BottomSheet(
          onClosing: () {},
          enableDrag: false,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.3,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          "Start Quest",
                          style: TextStyle(
                              fontSize: 27, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                                color: const Color.fromRGBO(21, 71, 52, 1))),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "San Luis Obispo Sight Seeing Quest",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 5),
                                            child: const Text(
                                              "6.2 Mi - 100 Coins",
                                              style:
                                                  TextStyle(color: Colors.grey),
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
                        onPressed: () {},
                        child: Container(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            margin: const EdgeInsets.only(top: 13, bottom: 13),
                            child: const Text(
                              "Next",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                  ),
                ],
              ),
            );
          },
        ),
        body: GoogleMap(
          mapType: MapType.normal,
          buildingsEnabled: true,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          trafficEnabled: true,
          initialCameraPosition: initialPos,
          //markers: hermeMarkers.values.toSet(),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}

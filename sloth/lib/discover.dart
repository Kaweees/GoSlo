import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  var discover = [
    {
      "name": "Kruzberg California",
      "visited": false,
      "icon":
          "https://coffeegroundsinslo.files.wordpress.com/2012/01/dsc_01691.jpg"
    },
    {
      "name": "Inn Cafe",
      "visited": true,
      "icon":
          "https://costar.brightspotcdn.com/2d/e7/c29d1e984086ab4d84b8d649c6ef/main.jpg"
    },
    {
      "name": "Woodstock Pizza",
      "visited": true,
      "icon":
          "https://i0.wp.com/www.yachats.org/wp-content/uploads/2020/02/Drift-Inn-Cafe-Outdoor-Seating-scaled-e1598772587881.jpg?resize=600%2C316&ssl=1"
    },
    {
      "name": "Big Skye Cafe",
      "visited": true,
      "icon":
          "https://ca-times.brightspotcdn.com/dims4/default/4f9761e/2147483647/strip/true/crop/3500x1969+0+0/resize/1200x675!/quality/80/?url=https%3A%2F%2Fcalifornia-times-brightspot.s3.amazonaws.com%2Fa3%2Fbc%2F967153f7443ab69d6b182b91b1f4%2Ffo-quickbites-07102022-02.jpg"
    },
    {
      "name": "Thai Elephant",
      "visited": false,
      "icon":
          "https://www.inquirer.com/resizer/Qfkh27yjOSyWlUYjxVkbFjSK0tg=/3x0:3840x2560/760x507/filters:format(webp)/cloudfront-us-east-1.images.arcpublishing.com/pmn/QKAZILLNF5CCNBXPLRTW7ZIR6I.jpg"
    },
    {
      "name": "Hawian BBQ",
      "visited": false,
      "icon":
          "https://cdn.cnn.com/cnnnext/dam/assets/220224234111-04-j-hotel-shanghai-tower.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 25),
              child: Text(
                "Discover",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 25),
              child: Text(
                "150 Small businesses near me",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 25),
              child: Row(children: [
                ChoiceChip(
                  label: Text(
                    "Featured",
                    style: TextStyle(color: Colors.white),
                  ),
                  selected: true,
                  selectedColor: const Color.fromRGBO(21, 71, 52, 1),
                ),
                SizedBox(
                  width: 5,
                ),
                ChoiceChip(
                  label: Text(
                    "Restaurants",
                    style: TextStyle(color: Colors.white),
                  ),
                  selected: false,
                  selectedColor: const Color.fromRGBO(21, 71, 52, 1),
                ),
                SizedBox(
                  width: 5,
                ),
                ChoiceChip(
                  label: Text(
                    "Attractions",
                    style: TextStyle(color: Colors.white),
                  ),
                  selected: false,
                  selectedColor: const Color.fromRGBO(21, 71, 52, 1),
                ),
                SizedBox(
                  width: 10,
                ),
                ChoiceChip(
                  label: Text(
                    "More",
                    style: TextStyle(color: Colors.white),
                  ),
                  selected: false,
                  selectedColor: const Color.fromRGBO(21, 71, 52, 1),
                ),
              ]),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.65,
                width: MediaQuery.of(context).size.width * 1,
                margin: EdgeInsets.only(top: 10),
                child: Center(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: discover.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        margin: EdgeInsets.only(
                            bottom: 10,
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.05),
                        height: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x53000000),
                                offset: Offset(0, 2),
                              )
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  width: 60,
                                  height: 60,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                        fit: BoxFit.cover,
                                        discover[index]["icon"].toString()),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10, top: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        discover[index]["name"].toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        discover[index]["visited"] == true
                                            ? "Visited"
                                            : "",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 15),
                              child: const Icon(
                                Icons.directions,
                                size: 30,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

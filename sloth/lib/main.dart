// Imports
import 'package:database/database.dart';
import 'package:flutter/material.dart';
import 'package:sloth/dashboard.dart';
import 'package:sloth/onboarding.dart';
import 'package:sloth/wrapper.dart';

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
          context, MaterialPageRoute(builder: (context) => const Dashboard()));
    });
  }

  
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


  Future<void> configDatabase() async {
    // Use an in-memory database
    final database = MemoryDatabaseAdapter().database();

    // Our collection
    final collection = database.collection('Quests');

    // Our document
    final document = collection.newDocument();

    // Insert a pizza
    await document.insert(data: {

    });

    // ...
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
          child: const Align(
              alignment: AlignmentDirectional(0, 0),
              child: /*Image.asset(
              'lib/assets/hermeats_logo.png',
              width: MediaQuery.of(context).size.width * 0.5,
              fit: BoxFit.fitWidth,
            ),
            */
                  Icon(Icons.map)),
        ),
      ),
    );
  }
}

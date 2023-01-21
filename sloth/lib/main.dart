// Imports
import 'package:flutter/material.dart';
import 'package:sloth/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const WelcomePage()));
    });
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
          child: Align(
              alignment: const AlignmentDirectional(0, 0),
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

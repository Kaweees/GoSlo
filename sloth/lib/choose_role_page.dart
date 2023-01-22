import 'package:flutter/material.dart';

class ChooseRolePage extends StatefulWidget {
  const ChooseRolePage({super.key});

  @override
  State<ChooseRolePage> createState() => _ChooseRolePageState();
}

class _ChooseRolePageState extends State<ChooseRolePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(
            top: 240,
            left: 100,
          ),
          // ignore: unnecessary_new
          child: new Column(children: [
            const Text(
              "I am looking to...",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            Column(
              children: [
                OutlinedButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF154734)),
                  ),
                  onPressed: () {},
                  child: Row(children: const [
                    Text(
                      'Sight See ',
                      style: TextStyle(fontSize: 25),
                    ),
                    Icon(Icons.visibility)
                  ]),
                ),
                OutlinedButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: () {},
                  child: Row(children: const [
                    Text('Shop Around ', style: TextStyle(fontSize: 25)),
                    Icon(Icons.store)
                  ]),
                ),
                OutlinedButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: () {},
                  child: Row(children: const [
                    Text('Meet New People ', style: TextStyle(fontSize: 25)),
                    Icon(Icons.share_location)
                  ]),
                ),
                OutlinedButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: () {},
                  child: Row(children: const [
                    Text('Just Explore ', style: TextStyle(fontSize: 25)),
                    Icon(Icons.visibility)
                  ]),
                )
              ],
            ),
            Column(children: [
              OutlinedButton(
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF154734))),
                onPressed: () {},
                child: Row(children: const [
                  Text('      Continue       ', style: TextStyle(fontSize: 25))
                ]),
              )
            ])
          ]),
        ),
      ),
    );
  }
}

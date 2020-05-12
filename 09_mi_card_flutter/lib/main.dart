import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        // appBar: AppBar(
        //   title: Text("Demo"),
        //   backgroundColor: Colors.tealAccent,
        // ),
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50.0,
              backgroundColor: Colors.red,
              backgroundImage: AssetImage("images/avatar.png"),
            ),
            Text(
              "Jhonatan Morais",
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 40.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "FULLSTACK DEVELOPER",
              style: TextStyle(
                  fontFamily: 'SourceSansPro',
                  color: Colors.teal[100],
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.5),
            ),
            SizedBox(
              height: 25.0,
              width: 150.0,
              child: Divider(color: Colors.teal[100]),
            ),
            // Card(
            //     margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
            //     child: ListTile(
            //       leading: Icon(
            //         Icons.phone,
            //         color: Colors.teal,
            //       ),
            //       title: Text(
            //         "+55 61 9 9993 9043",
            //         style: TextStyle(
            //             fontFamily: 'SourceSansPro',
            //             color: Colors.teal[900],
            //             fontSize: 20.0),
            //       ),
            //     )),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.email,
                  color: Colors.teal,
                ),
                title: Text(
                  "jhonatanvinicius@gmail.com",
                  style: TextStyle(
                      fontFamily: 'SourceSansPro',
                      color: Colors.teal[900],
                      fontSize: 15.0),
                ),
              ),
            )
          ],
        )),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

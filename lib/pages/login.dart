// @dart=2.9

import 'package:flutter/material.dart';
import 'package:noteapp/auth/google_auth.dart';
// import 'package:noteapp/pages/homepage.dart';

class LoginPage extends StatefulWidget {
  // static const routeName = '/login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Remarques'),
        backgroundColor: Colors.indigo[900],
      ), 
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Image.asset(
              'images/read.png',
              height: 300,
              width: 300,
            ),
            // Icon(Icons.person),
            SizedBox(
              height: 30,
            ),
            Text(
              "Create and Edit Notes",
              style: TextStyle(
                  fontSize: 35,
                  color: Colors.indigo,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                signInWithGoogle(context);
                // Navigator.of(context).pushReplacementNamed(HomePage.routeName);
              },
              child: Text(
                '\n Login with Google \n',
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

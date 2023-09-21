// @dart=2.9

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'package:noteapp/pages/addnote.dart';
import 'package:noteapp/pages/viewnote.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('notes');
  List<Color> myColors = [
    Colors.blue[200],
    Colors.red[100],
    Colors.blueAccent,
    Colors.green[100],
    Colors.deepPurple[100],
    Colors.purple[100],
    Colors.cyan[100],
    Colors.teal[100],
    Colors.tealAccent[100],
    Colors.pink[100],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Remarques'),
        backgroundColor: Colors.indigo[900],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => AddNote(),
            ),
          )
              .then((value) {
            print('Call set state');
            setState(() {});
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.indigo,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: ref.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                Random random = new Random();
                Color bg = myColors[random.nextInt(9)];
                Map data = snapshot.data.docs[index].data();

                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            ViewNote(data, snapshot.data.docs[index].reference),
                      ),
                    ).then((value){
                      setState(() {
                        
                      });
                    }
                    );
                  },
                  child: Card(
                    color: bg,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "${data['title']}",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text('Loading...'),
            );
          }
        },
      ),
    );
  }
}

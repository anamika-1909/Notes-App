// @dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  String title;
  String des;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Remarques'),
          backgroundColor: Colors.indigo[900],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: add,
          child: Icon(
            Icons.save,
            color: Colors.white,
          ),
          backgroundColor: Colors.indigo,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [
                Form(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 4,
                      ),
                      TextFormField(
                        decoration:
                            InputDecoration.collapsed(hintText: 'Add Title'),
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w600),
                        onChanged: (_val) {
                          title = _val;
                        },
                        
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        padding: const EdgeInsets.only(top: 10),
                        child: TextFormField(
                          decoration: InputDecoration.collapsed(
                              hintText: 'Add your Note'),
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w400),
                          onChanged: (_val) {
                            des = _val;
                          },
                          maxLines: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void add() async {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('notes');

    var data = {'title': title, 'description': des,};
    ref.add(data);
    Navigator.pop(context);
  }
}

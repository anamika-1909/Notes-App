// @dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewNote extends StatefulWidget {
  final Map data;
  final DocumentReference ref;

  ViewNote(this.data, this.ref);
  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  String title;
  String des;
  bool edit = false;

  GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    title = widget.data['tile'];
    des = widget.data['description'];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Remarques'),
          backgroundColor: Colors.indigo[900],
        ),
        floatingActionButton: edit
            ? FloatingActionButton(
                onPressed: save,
                child: Icon(Icons.save),
                backgroundColor: Colors.indigo,
              )
            : null,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ElevatedButton(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.edit),
                            ],
                          ),
                          onPressed: () {
                            setState(() {
                              edit = !edit;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blueGrey,
                          ),
                        ),
                        SizedBox(
                          width: 230,
                        ),
                        ElevatedButton(
                          onPressed: delete,
                          child: Icon(
                            Icons.delete_forever,
                            color: Colors.white,
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Form(
                      key: key,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration.collapsed(
                                hintText: 'Add Title'),
                            style: TextStyle(
                                fontSize: 35.0, fontWeight: FontWeight.w600),
                            initialValue: widget.data['title'],
                            enabled: edit,
                            onChanged: (_val) {
                              title = _val;
                            },
                            validator: (_val) {
                              if (_val.isEmpty) {
                                return "Cannot be null";
                              } else {
                                return null;
                              }
                            },
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.75,
                            child: TextFormField(
                              decoration: InputDecoration.collapsed(
                                  hintText: 'Add your Note'),
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.w400),
                              initialValue: widget.data['description'],
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void delete() async {
    await widget.ref.delete();
    Navigator.pop(context);
  }

  void save() async {
    await widget.ref.update(
      {'title': title, 'description': des},
    );
    Navigator.of(context).pop();
  }
}

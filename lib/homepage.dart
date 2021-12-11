// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController taskController = TextEditingController();
  addData() async {
    FirebaseFirestore.instance.collection('tasks').add({
      'task': taskController.text,
      'date':
          '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day},'
    });
    taskController.clear();
  }

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('tasks').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.all(13),
                child: Card(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.7,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        child: TextField(
                          controller: taskController,
                          decoration: const InputDecoration(
                            hintText: 'Enter Task',
                          ),
                        ),
                      ),
                      OutlineButton(
                        onPressed: () {
                          addData();
                        },
                        child: const Text('Add Task'),
                      )
                    ],
                  ),
                )),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _usersStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Container(
                    child: ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return Container(
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide()),
                          ),
                          child: ListTile(
                            title: Text(data['task']),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${data['date']}',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),

                            //
                            // trailing:

                            trailing: Wrap(
                              spacing: 1, // space between two icons
                              children: <Widget>[
                                IconButton(
                                    onPressed: () {
                                      document.reference.delete();
                                    },
                                    icon: Icon(Icons.delete)),
                                IconButton(
                                    onPressed: () {
                                      showEditDialog(
                                          BuildContext,
                                          data['task'],
                                          () => document.reference.update({
                                                'task': editTaskController.text
                                              }));
                                    },
                                    icon: Icon(Icons.edit)),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextEditingController editTaskController = TextEditingController();
  void showEditDialog(
    BuildContext,
    title,
    void callb(),
  ) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit Task'),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    child: TextField(
                      controller: editTaskController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                        ),
                        hintText: 'Edit $title',
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        side: BorderSide(
                            width: 3,
                            color: Colors.transparent), //border width and color
                        elevation: 3, //elevation of button
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(5)),
                        padding: EdgeInsets.all(20)),
                    onPressed: () {
                      callb();
                      Navigator.pop(context);
                      editTaskController.clear();
                    },
                    label: const Text('Edit'),
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

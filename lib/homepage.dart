// ignore_for_file: avoid_unnecessary_containers

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
      'date': '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day},'
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
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
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
                                SizedBox(height: 5,),
                                Text(
                                  '${data['date']}',
                                  style: TextStyle(
                                      fontSize: 16.0, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5,),
                                
                               
                  
                              ],
                            ),
                            //
                            trailing: IconButton(
                                onPressed: () {
                                  document.reference.delete();
                                },
                                icon: Icon(Icons.delete))
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
}

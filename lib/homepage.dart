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
    });
  }

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('tasks').snapshots();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            child: Card(
          child: Column(
            children: [
              Container(
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
        //   StreamBuilder<QuerySnapshot>(
        //   stream: _usersStream,
        //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //     if (snapshot.hasError) {
        //       return Text('Something went wrong');
        //     }

        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Text("Loading");
        //     }

        //     return Container(
        //       child: ListView(
        //         children: snapshot.data!.docs.map((DocumentSnapshot document) {
        //           Map<String, dynamic> data =
        //               document.data()! as Map<String, dynamic>;
        //           return Container(
        //             decoration: BoxDecoration(
        //               //                    <-- BoxDecoration
        //               border: Border(bottom: BorderSide()),
        //             ),
        //             child: ListTile(
        //               title: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,

        //                 children: [
        //                   SizedBox(height: 5,),
        //                   Text(
        //                     'Date: ${data['Date']}',
        //                     style: TextStyle(
        //                         fontSize: 16.0, fontWeight: FontWeight.bold),
        //                   ),
        //                   SizedBox(height: 5,),
        //                   // subtitle:
        //                   Text(
        //                     'Morning Rate: ${data['Morning Rate']}',
        //                     style: TextStyle(fontSize: 16.0),
        //                   ),
        //                   SizedBox(height: 5,),
        //                   Text(
        //                     'Evening Rate: ${data['Evening Rate']}',
        //                     style: TextStyle(fontSize: 16.0),
        //                   ),

        //                 ],
        //               ),
        //               //
        //               trailing: IconButton(
        //                   onPressed: () {
        //                     document.reference.delete();
        //                   },
        //                   icon: Icon(Icons.delete)),

        //               // trailing: Column(
        //               //   children:[
        //               //     SizedBox(height: 3.0,),

        //               //   ],

        //               // ),
        //               // subtitle: Text(data['Morning Rate']),
        //             ),
        //           );
        //         }).toList(),
        //       ),
        //     );
        //   },
        // ),
      ],
    );
  }
}

// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController taskController = TextEditingController();
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
                decoration:BoxDecoration(
                  shape: BoxShape.rectangle,
                  border:Border.all(
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
              )
            ],
          ),
        ))
      ],
    );
  }
}

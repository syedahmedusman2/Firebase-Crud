// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({ Key? key }) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Card(
            child: Column(children: [
              Container(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter Task',
                  ),
                ),
              )
            ],),
          )
        )
      ],
      
    );
  }
}
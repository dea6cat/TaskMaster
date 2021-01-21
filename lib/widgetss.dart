import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  final String title;
  final String desc;
  TaskCardWidget({this.title, this.desc});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 32.0,
        horizontal: 24.0,
      ),
      margin: EdgeInsets.only(bottom: 13.0),
      decoration: BoxDecoration(
          color: Colors.white,
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "Unnamed task!",
            style: TextStyle(
              color: Color(0xFF211551),
              fontSize: 22.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            desc ?? "No description, add one. ",
          style: TextStyle(
            color: Color(0xFF86829D),
            fontWeight: FontWeight.normal,
            fontSize: 16.0,
            height: 1.2,
          ),),
        ],
      ),
    );
  }
}

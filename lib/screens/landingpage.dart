//import 'dart:html';

import 'dart:ui';
import 'package:get_it_done/helpers/database_helper.dart';
import 'package:get_it_done/models/task_model.dart';
import 'package:get_it_done/screens/add_task.dart';
import 'package:intl/intl.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:get_it_done/widgetss.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Future<List<Task>> _taskList;
  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');

  @override
  void initState() {
    super.initState();
    _updateTaskList();
  }

  _updateTaskList() {
    setState(() {
      _taskList = DatabaseHelper.instance.getTaskList();
    });
  }

  Widget _buildTask(Task task) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 25.0),
      child: Column(
        children: [
          ListTile(
            title: Text(
              task.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                decoration: task.status == 0
                    ? TextDecoration.none
                    : TextDecoration.lineThrough,
              ),
            ),
            subtitle: Text(
              '${_dateFormatter.format(task.date)} - ${task.priority}',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  decoration: task.status == 0
                      ? TextDecoration.none
                      : TextDecoration.lineThrough),
            ),
            trailing: Checkbox(
              onChanged: (value) {
                task.status = value ? 1 : 0;
                DatabaseHelper.instance.updateTask(task);
                _updateTaskList();
              },
              activeColor: const Color(0XFF03DAC5),
              value: task.status == 1 ? true : false,
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => addTask(
                  updateTaskList: _updateTaskList,
                  task: task,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0XFFFEDB0),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0XFF03DAC5),
        //Theme.of(context).primaryColor, //
        foregroundColor: Colors.white,
        onPressed: () {
          print("adding a task");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => addTask(
                updateTaskList: _updateTaskList,
              ),
            ),
          );
        },
        icon: Icon(Icons.add),
        label: Text(
          'New',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: FutureBuilder(
          future: _taskList,
          builder: (context, snapshot) {
            // ignore: unrelated_type_equality_checks
            if (_taskList == null) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    "You have no tasks yet. Get started.",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
                  ),
                ),
              );
            }

            final int completedTasks = snapshot.data
                .where((Task task) => task.status == 1)
                .toList()
                .length;

            return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 17.0),
                itemCount: 1 + snapshot.data.length,
                itemBuilder: (BuildContext context, int i) {
                  if (i == 0) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "Tasks",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "$completedTasks of ${snapshot.data.length}",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return _buildTask(snapshot.data[i - 1]);
                });
          }),
    );
  }
}

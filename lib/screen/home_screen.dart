// ignore_for_file: unnecessary_null_comparison

import 'package:example_hive/model/task_model.dart';
import 'package:example_hive/screen/add_task_screen.dart';
import 'package:example_hive/utlity/open_page.dart';
import 'package:example_hive/widget/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String status = "hello world";

  final taskBox = Hive.box<TaskModel>("task");
  bool isFabVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe5e5e5),
      floatingActionButton: Visibility(
        visible: isFabVisible,
        child: FloatingActionButton(
          onPressed: () {
            openPage(AddTaskScreen(), context);
          },
          backgroundColor: Color(0xff18daa3),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: taskBox.listenable(),
        builder: (BuildContext context, dynamic value, Widget? child) {
          return NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              setState(() {
                if (notification.direction == ScrollDirection.forward) {
                  isFabVisible = true;
                }
                if (notification.direction == ScrollDirection.reverse) {
                  isFabVisible = false;
                }
              });
              return true;
            },
            child: ListView.builder(
              itemCount: taskBox.values.length,
              itemBuilder: (context, index) {
                var task = taskBox.values.toList()[index];
                return getListItem(task);
              },
            ),
          );
        },
      ),
    );
  }

  Widget getListItem(TaskModel task) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        task.delete();
      },
      child: TaskWidget(task: task),
    );
  }
}

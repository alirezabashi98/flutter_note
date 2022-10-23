import 'package:example_hive/model/task_model.dart';
import 'package:example_hive/screen/add_task_screen.dart';
import 'package:example_hive/screen/edit_task_screen.dart';
import 'package:example_hive/utlity/open_page.dart';
import 'package:flutter/material.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({Key? key, required this.task}) : super(key: key);
  final TaskModel task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: true, //!widget.task.isDone,
        child: _getTaskItem());
  }

  Widget _getTaskItem() {
    return GestureDetector(
      onTap: () {
        update();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        height: 132,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: _getMainContent(),
        ),
      ),
    );
  }

  Widget _getMainContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Transform.scale(
                    scale: 1.4,
                    child: Checkbox(
                      value: widget.task.isDone,
                      checkColor: Colors.white,
                      activeColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      onChanged: (onChanged) {
                        update();
                      },
                    ),
                  ),
                  Text(widget.task.title),
                ],
              ),
              Text(widget.task.subtitle),
              Spacer(),
              _getTimeAndEditBadgs(),
            ],
          ),
        ),
        SizedBox(width: 10),
        Image.asset(widget.task.taskType.image),
      ],
    );
  }

  Widget _getTimeAndEditBadgs() {
    return Row(
      children: [
        Container(
          height: 28,
          width: 90,
          decoration: BoxDecoration(
            color: Color(0xff18daa3),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: [
                Text(
                  "${widget.task.time.minute}:${widget.task.time.hour}",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                Image.asset("assets/images/icon_time.png"),
              ],
            ),
          ),
        ),
        SizedBox(width: 15),
        InkWell(
          onTap: () {
            openPage(EditTaskScreen(task: widget.task), context);
          },
          child: Container(
            height: 28,
            width: 90,
            decoration: BoxDecoration(
              color: Color(0xffe2f6f1),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Text(
                    "ویرایش",
                    style: TextStyle(
                      color: Color(0xff18daa3),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                  Image.asset("assets/images/icon_edit.png"),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  update() {
    setState(() {
      widget.task.isDone = !widget.task.isDone;
      widget.task.save();
    });
  }
}

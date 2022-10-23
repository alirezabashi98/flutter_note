import 'package:flutter/material.dart';

import '../model/task_type_model.dart';

class TaskTypeItemList extends StatelessWidget {
  TaskTypeItemList(
      {Key? key, required this.taskType, required this.selectedItemList})
      : super(key: key);

  TaskTypeModel taskType;
  bool selectedItemList;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: selectedItemList ? Color(0xff18daa3) : Colors.transparent,
        border: Border.all(
          color: selectedItemList ? Colors.green : Colors.grey,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      width: 140,
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          Image.asset(taskType.image),
          Text(
            taskType.title,
            style: TextStyle(
              fontSize: selectedItemList ? 20 : 18,
              color: selectedItemList ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

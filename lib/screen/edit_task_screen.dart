import 'package:example_hive/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:time_pickerr/time_pickerr.dart';
import '../utlity/utility.dart';
import '../widget/task_type_item_list.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({Key? key, required this.task}) : super(key: key);
  final TaskModel task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();
  late final TextEditingController controllerTaskTitle;
  late final TextEditingController controllerTaskSubTitle;

  final taskBox = Hive.box<TaskModel>('task');

  late int _selectedIndexTaskType = 2;
  late DateTime _time;

  @override
  void initState() {
    super.initState();
    controllerTaskTitle = TextEditingController(text: widget.task.title);
    controllerTaskSubTitle = TextEditingController(text: widget.task.subtitle);

    negahban1.addListener(() {
      setState(() {});
    });

    negahban2.addListener(() {
      setState(() {});
    });

    _time = widget.task.time;

    _selectedIndexTaskType = getTaskList().indexWhere((element) {
      return element.taskTypeEnum == widget.task.taskType.taskTypeEnum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 4,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: controllerTaskTitle,
                    focusNode: negahban1,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      labelText: 'عنوان تسک',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: negahban1.hasFocus
                            ? Color(0xff18DAA3)
                            : Color(0xffC5C5C5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide:
                            BorderSide(color: Color(0xffC5C5C5), width: 3.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          width: 3,
                          color: Color(0xff18DAA3),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: controllerTaskSubTitle,
                    maxLines: 2,
                    focusNode: negahban2,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      labelText: 'عنوان تسک',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: negahban2.hasFocus
                            ? Color(0xff18DAA3)
                            : Color(0xffC5C5C5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide:
                            BorderSide(color: Color(0xffC5C5C5), width: 3.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(
                          width: 3,
                          color: Color(0xff18DAA3),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: CustomHourPicker(
                  title: "زمان تسک رو انتخاب کن",
                  titleStyle: TextStyle(
                    color: Color(0xff18daa3),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  negativeButtonStyle: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  positiveButtonStyle: TextStyle(
                    color: Color(0xff18daa3),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  negativeButtonText: "حذف کن",
                  positiveButtonText: "انتخاب کن",
                  elevation: 2,
                  onPositivePressed: (context, time) {
                    this._time = time;
                  },
                  onNegativePressed: (context) {},
                ),
              ),
              Container(
                height: 180,
                child: ListView.builder(
                  itemCount: getTaskList().length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => setState(() {
                        _selectedIndexTaskType = index;
                      }),
                      child: TaskTypeItemList(
                        taskType: getTaskList()[index],
                        selectedItemList: (index == _selectedIndexTaskType),
                      ),
                    );
                  },
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  String taskTitle = controllerTaskTitle.text;
                  String taskSubTitle = controllerTaskSubTitle.text;

                  if (taskTitle.isNotEmpty && taskSubTitle.isNotEmpty)
                    updateTask(taskTitle, taskSubTitle);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'ویرایش کردن تسک',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff18DAA3),
                  minimumSize: Size(200, 48),
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  updateTask(String taskTitle, String taskSubTitle) {
    widget.task.title = taskTitle;
    widget.task.subtitle = taskSubTitle;
    widget.task.time = _time;
    widget.task.taskType = getTaskList()[_selectedIndexTaskType];
    widget.task.save();
  }
}

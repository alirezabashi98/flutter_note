import 'package:hive/hive.dart';
import 'package:example_hive/model/task_type_model.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String subtitle;
  @HiveField(2, defaultValue: false)
  bool isDone;
  @HiveField(3)
  DateTime time;
  @HiveField(4)
  TaskTypeModel taskType;

  TaskModel({
    required this.title,
    required this.subtitle,
    this.isDone = false,
    required this.time,
    required this.taskType,
  });
}

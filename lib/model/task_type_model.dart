import 'package:hive_flutter/hive_flutter.dart';

import '../enums/type_enum.dart';
part 'task_type_model.g.dart';

@HiveType(typeId: 2)
class TaskTypeModel {
  TaskTypeModel({
    required this.image,
    required this.title,
    required this.taskTypeEnum,
  });

  @HiveField(0)
  String image;
  @HiveField(1)
  String title;
  @HiveField(2)
  TaskTypeEnum taskTypeEnum;
}

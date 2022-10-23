import 'package:example_hive/enums/type_enum.dart';
import 'package:example_hive/model/task_type_model.dart';

List<TaskTypeModel> getTaskList() => [
      TaskTypeModel(
          image: "assets/images/meditate.png",
          title: "تمرکز",
          taskTypeEnum: TaskTypeEnum.foucs),
      TaskTypeModel(
          image: "assets/images/social_frends.png",
          title: "میتینگ",
          taskTypeEnum: TaskTypeEnum.date),
      TaskTypeModel(
          image: "assets/images/hard_working.png",
          title: "کار زیاد",
          taskTypeEnum: TaskTypeEnum.working),
    ];

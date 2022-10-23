import 'package:example_hive/model/task_model.dart';
import 'package:example_hive/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'enums/type_enum.dart';
import 'model/task_type_model.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(TaskTypeModelAdapter());
  Hive.registerAdapter(TaskTypeEnumAdapter());

  await Hive.openBox<TaskModel>("task");

  runApp(Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'SM',
        textTheme: TextTheme(
          headline4: TextStyle(
            fontFamily: 'SM',
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

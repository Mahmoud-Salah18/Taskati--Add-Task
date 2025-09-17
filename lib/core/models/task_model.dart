import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String? date;
  @HiveField(4)
  String? startTime;
  @HiveField(5)
  String? endtTime;
  @HiveField(6)
  int? color;
  @HiveField(7)
  bool? isCompleted;
  @HiveField(8)
  int? repeat;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.date,
    this.startTime,
    this.endtTime,
    this.color,
    this.isCompleted,
    this.repeat,
  });

   TaskModel copywith({
    String? id,
    String? title,
    String? description,
    String? date,
    String? startTime,
    String? endtTime,
    int? color,
    bool? isCompleted,
    int? repeat,
   }

   ){
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endtTime: endtTime ?? this.endtTime,
      color: color ?? this.color,
      isCompleted: isCompleted ?? this.isCompleted,
      repeat: repeat ?? this.repeat,

    );
   }
}

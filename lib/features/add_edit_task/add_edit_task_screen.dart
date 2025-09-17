import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/constants/task_colors.dart';
import 'package:taskati/core/functions/navigation.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/services/local_helper.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/core/widgets/custom_text_field.dart';
import 'package:taskati/core/widgets/main_button.dart';
import 'package:taskati/features/home/page/home_screen.dart';

class AddEditTaskScreen extends StatefulWidget {
  const AddEditTaskScreen({super.key, this.model});
  final TaskModel? model;

  @override
  State<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var dateController = TextEditingController(
    text: DateFormat("yyyy-MM-dd").format(DateTime.now()),
  );
  var startTimeController = TextEditingController();
  var endTimeController = TextEditingController(
  );

  @override
  void initState() {
    titleController.text = widget.model?.title ?? "";
    descriptionController.text = widget.model?.description ?? "";
    dateController.text = widget.model?.date ?? "";
    startTimeController.text =
        widget.model?.startTime ?? DateFormat("hh:mm a").format(DateTime.now());
    endTimeController.text =
        widget.model?.endtTime ?? DateFormat("hh:mm a").format(DateTime.now());
    currentIndex = widget.model?.color?? 0 ;
    super.initState();
  }

  var formKey = GlobalKey<FormState>();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.model!= null? "Edit Task" : "Add Task")),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 5),
          child: MainButton(
            text: widget.model!= null? "Update Task":"Create Task",
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                String id = widget.model != null? widget.model?.id ?? "":
                    DateTime.now().microsecondsSinceEpoch.toString() +
                    titleController.text;
                await LocalHelper.putTask(
                  id,
                  TaskModel(
                    id: id,
                    title: titleController.text,
                    description: descriptionController.text,
                    date: dateController.text,
                    startTime: startTimeController.text,
                    endtTime: endTimeController.text,
                    color: currentIndex,
                    isCompleted: false,
                  ),
                );
                pushAndRemoveUntil(context, HomeScreen());
              }
            },
          ),
        ),
      ),
      body: _addTaskBody(),
    );
  }

  SingleChildScrollView _addTaskBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Title", style: TextStyles.bodyStyle()),
              SizedBox(height: 6),
              CustomTextField(
                controller: titleController,
                hint: "Enter Task Title",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Task Title";
                  }
                },
              ),
              SizedBox(height: 10),
              Text("Description (Optional)", style: TextStyles.bodyStyle()),
              SizedBox(height: 6),
              CustomTextField(
                controller: descriptionController,
                hint: "Enter Task Description",
                maxLines: 3,
              ),
              SizedBox(height: 10),
              _dateFields(),
              SizedBox(height: 10),
              timeFields(),
              SizedBox(height: 10),
              Row(
                spacing: 6,
                children: List.generate(3, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: colors[index],
                      child: currentIndex == index
                          ? Icon(Icons.check, color: AppColors.whiteColor)
                          : null,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _dateFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Date", style: TextStyles.bodyStyle()),
        SizedBox(height: 6),
        CustomTextField(
          controller: dateController,
          readOnly: true,
          onTap: () async {
            var selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2050),
            );

            if (selectedDate != null) {
              dateController.text = DateFormat(
                "yyyy-MM-dd",
              ).format(selectedDate);
            }
          },
          suffixIcon: Icon(
            Icons.calendar_month_rounded,
            color: AppColors.primaryColor,
          ),
          hint: "Enter Task Date",
        ),
      ],
    );
  }

  Row timeFields() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Start Time", style: TextStyles.bodyStyle()),
              SizedBox(height: 6),
              CustomTextField(
                controller: startTimeController,
                readOnly: true,
                onTap: () async {
                  var selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (selectedTime != null) {
                    startTimeController.text = selectedTime.format(context);
                  }
                },
                suffixIcon: Icon(
                  Icons.watch_later_outlined,
                  color: AppColors.primaryColor,
                ),
                hint: "Enter Task Date",
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("End Time", style: TextStyles.bodyStyle()),
              SizedBox(height: 6),
              CustomTextField(
                controller: endTimeController,
                readOnly: true,
                onTap: () async {
                  var selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (selectedTime != null) {
                    endTimeController.text = selectedTime.format(context);
                  }
                },
                suffixIcon: Icon(
                  Icons.watch_later_outlined,
                  color: AppColors.primaryColor,
                ),
                hint: "Enter Task Date",
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/functions/navigation.dart';
import 'package:taskati/core/services/local_helper.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/core/widgets/main_button.dart';
import 'package:taskati/features/add_edit_task/add_edit_task_screen.dart';

class TodayHeader extends StatelessWidget {
  const TodayHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMd().format(DateTime.now()),
                style: TextStyles.titleStyle(color: AppColors.primaryColor),
              ),
              Text("Today", style: TextStyles.bodyStyle()),
            ],
          ),
        ),
        MainButton(
          width: 140,
          height: 40,
          text: "+ Add Task",
          onPressed: () {
            pushTo(context, AddEditTaskScreen());
          },
        ),
      ],
    );
  }
}

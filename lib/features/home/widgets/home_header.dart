import 'dart:io';
import 'package:flutter/material.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/services/local_helper.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, ${LocalHelper.getData(LocalHelper.kname)}",
                style: TextStyles.titleStyle(
                  color: AppColors.primaryColor,
                ),
              ),
              Text("Have a Nice day", style: TextStyles.bodyStyle(),),
            ],
          ),
        ),
        CircleAvatar(
          radius: 26,
          backgroundColor: AppColors.primaryColor,
          backgroundImage:
              LocalHelper.getData(LocalHelper.kimage) != null
              ? FileImage(
                  File(LocalHelper.getData(LocalHelper.kimage)),
                )
              : AssetImage(AppImages.emptyUser),
        ),
      ],
    );
  }
}

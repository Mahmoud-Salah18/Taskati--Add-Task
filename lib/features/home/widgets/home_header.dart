import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/services/local_helper.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/features/profile_screen/profile_screen.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final imagePath = LocalHelper.getData(LocalHelper.kimage);

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, ${LocalHelper.getData(LocalHelper.kname) ?? "Guest"}",
                style: TextStyles.titleStyle(color: AppColors.primaryColor),
              ),
              Text("Have a Nice day", style: TextStyles.bodyStyle()),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            LocalHelper.changeTheme();
          },
          icon: Icon(Icons.dark_mode, color: AppColors.orangeColor),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
          },
          child: CircleAvatar(
            radius: 26,
            backgroundColor: AppColors.primaryColor,
            backgroundImage: imagePath != null
                ? FileImage(File(imagePath))
                : AssetImage(AppImages.emptyUser) as ImageProvider,
          ),
        ),
      ],
    );
  }
}

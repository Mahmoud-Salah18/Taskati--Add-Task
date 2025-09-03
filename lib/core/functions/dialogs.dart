import 'package:flutter/material.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';

showErrorDialog(BuildContext context, String message){
  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10)
                    ),
                    elevation: 0,
                    backgroundColor: AppColors.redColor,
                    content: Text(
                     message,
                      style: TextStyles.bodyStyle(color: AppColors.whiteColor),
                    ),
                  ),
                );
}
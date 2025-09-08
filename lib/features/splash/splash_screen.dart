import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/functions/navigation.dart';
import 'package:taskati/core/services/local_helper.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/features/home/page/home_screen.dart';
import 'package:taskati/features/upload/upload_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    bool isUploaded = LocalHelper.getData(LocalHelper.kIsUploaded) ?? false;
    Future.delayed(Duration(seconds: 3), () {
      if(isUploaded){
       pushWithReplacement(context, const HomeScreen());

      }else{
        pushWithReplacement(context, const UploadScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(AppImages.logoJson, width: 250),
            SizedBox(height: 15),
            Text(
              "Taskati",
              style: TextStyles.titleStyle  (
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 15),
            Text(
              "It\'s time to get organized",
              style: TextStyles.smallStyle(
                fontSize: 16,
                color: AppColors.greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

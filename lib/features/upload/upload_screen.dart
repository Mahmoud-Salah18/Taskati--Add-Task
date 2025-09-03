import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/core/constants/app_images.dart';
import 'package:taskati/core/functions/dialogs.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/widgets/custom_text_field.dart';
import 'package:taskati/core/widgets/main_button.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String path = "";
  var nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              if (path.isNotEmpty && nameController.text.isNotEmpty) {
                
              } else if (path.isNotEmpty && nameController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Please Enter Your Name")),
                );
              } else if (path.isEmpty && nameController.text.isNotEmpty) {
                showErrorDialog(context, "Please Upload Your Image");
              } else {
                showErrorDialog(context, "Please Enter Your Name And Upload Your Image  ");
              }
            },
            child: Text("Done"),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: AppColors.primaryColor,
                  backgroundImage: path.isNotEmpty
                      ? FileImage(File(path))
                      : AssetImage(AppImages.emptyUser),
                ),
                SizedBox(height: 20),
                MainButton(
                  width: 300,
                  onPressed: () async {
                    await uploadImage(isCamera: true);
                  },
                  text: "Upload From Camera",
                ),
                SizedBox(height: 15),
                MainButton(
                  width: 300,
                  onPressed: () async {
                    await uploadImage(isCamera: false);
                  },
                  text: "Upload From Gallery",
                ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 20),
                CustomTextField(
                  controller: nameController,
                  hint: "Enter Your Name ",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> uploadImage({required bool isCamera}) async {
    XFile? file = await ImagePicker().pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );

    if (file != null) {
      setState(() {
        path = file.path;
      });
    }
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskarti/Widget/widget.dart';
import 'package:taskarti/hive/hive.dart';
import 'package:taskarti/utils/ConstantFonts.dart';
import 'package:taskarti/utils/ConstantsColors.dart';

class ChangeIMageAndNameScreen extends StatefulWidget {
  const ChangeIMageAndNameScreen({super.key});

  @override
  State<ChangeIMageAndNameScreen> createState() =>
      _ChangeIMageAndNameScreenState();
}

class _ChangeIMageAndNameScreenState extends State<ChangeIMageAndNameScreen> {
  ImagePicker pick = ImagePicker();

  var image;
  var nameController = TextEditingController();
  var text = KHive.popUserBox(KHive.nameKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(context, "B", (route) => false);
          },
          child: Icon(Icons.arrow_back),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.wb_sunny_sharp),
          ),
        ],
        foregroundColor: Kcolors.maiColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsetsGeometry.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        width: double.infinity,
                        height: 150,
                        child: Column(
                          children: [
                            const Gap(20),
                            CustomElevatedButton(
                              horozantialPadding: 40,
                              text: "Upload From Camera",
                              onPressed: () async {
                                var file = await pick.pickImage(
                                  source: ImageSource.camera,
                                );
                                check(file);
                              },
                            ),
                            Gap(10),
                            CustomElevatedButton(
                              horozantialPadding: 40,
                              text: "Upload From Gallery",
                              onPressed: () async {
                                var file = await pick.pickImage(
                                  source: ImageSource.gallery,
                                );
                                check(file);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: FileImage(
                    File(KHive.popUserBox(KHive.imageKey)),
                  ),
                ),
              ),
              const Gap(40),
              const Divider(color: Kcolors.maiColor, indent: 20, endIndent: 20),
              const Gap(40),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    style: Kfonts.textStyle(
                      fontSize: 22,
                      color: Kcolors.maiColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: 600,
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsetsGeometry.all(20),
                              child: Column(
                                children: [
                                  CustomTextFormField(
                                    controller: nameController,
                                    hint: "Enter your name",
                                  ),
                                  Gap(20),
                                  CustomElevatedButton(
                                    horozantialPadding: 0,
                                    text: "Upload Your Name",
                                    onPressed: () {
                                      if (nameController.text.isNotEmpty) {
                                        KHive.pushUserBox(
                                          KHive.nameKey,
                                          nameController.text,
                                        );
                                      }
                                      setState(() {
                                        text = KHive.popUserBox(KHive.nameKey);
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.edit, color: Kcolors.maiColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void check(XFile? file) {
    if (file != null) {
      setState(() {
        image = file.path;
        KHive.pushUserBox(KHive.imageKey, image);
      });
      Navigator.pop(context);
    }
  }
}

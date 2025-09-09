import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskarti/Widget/widget.dart';
import 'package:taskarti/hive/hive.dart';
import 'package:taskarti/utils/ConstantIcons.dart';
import 'package:taskarti/utils/ConstantsColors.dart';

class Pickerimage extends StatefulWidget {
  const Pickerimage({super.key});

  @override
  State<Pickerimage> createState() => _PickerimageState();
}

class _PickerimageState extends State<Pickerimage> {
  ImagePicker pick = ImagePicker();
  TextEditingController nameController = TextEditingController();

  var image;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: ()async {
                if (nameController.text.isEmpty && image != null) {
                  Msnackbar("Inavlid Name");
                } else if (nameController.text.isNotEmpty && image == null) {
                  Msnackbar("Inesert Image");
                } else if (nameController.text.isEmpty && image == null) {
                  Msnackbar("Inesert Image And Name");
                } else if (nameController.text.isNotEmpty && image != null) {
                KHive.pushUserBox(KHive.nameKey, nameController.text);
                KHive.pushUserBox(KHive.imageKey, image);
                KHive.pushUserBox(KHive.boolKey,true);
                  Navigator.pushReplacementNamed(context, "B");
                }
              },
              child: Text("Done"),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage: image == null
                    ? AssetImage(KIcons.userpng)
                    : FileImage(File(image)),
                backgroundColor: Kcolors.maiColor,
              ),
              const Gap(20),
              CustomElevatedButton(
                horozantialPadding: 40,
                text: "Upload From Camera",
                onPressed: () async {
                  var file = await pick.pickImage(source: ImageSource.camera);
                  check(file);
                },
              ),
              Gap(10),
              CustomElevatedButton(
                horozantialPadding: 40,
                text: "Upload From Gallery",
                onPressed: () async {
                  var file = await pick.pickImage(source: ImageSource.gallery);
                  check(file);
                },
              ),
              const Gap(15),
              Divider(indent: 16, endIndent: 16),
              const Gap(15),
              CustomTextFormField(
                controller: nameController,
                hint: "Enter your name",
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
      });
    }
  }

  void Msnackbar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text, textAlign: TextAlign.center),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

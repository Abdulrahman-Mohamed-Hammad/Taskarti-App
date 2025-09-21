import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskarti/Widget/widget.dart';
import 'package:taskarti/hive/hive.dart';
import 'package:taskarti/hive/modelTask.dart';
import 'package:taskarti/utils/ConstantFonts.dart';
import 'package:taskarti/utils/ConstantsColors.dart';
import 'package:intl/intl.dart';

List<Color> color = [Kcolors.maiColor, Kcolors.orange, Kcolors.red,Colors.green];

class AddTask extends StatefulWidget {
  final TaskModel? model;
  const AddTask({super.key, this.model});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late TextEditingController controllertitle = TextEditingController();

  TextEditingController controllerDescription = TextEditingController();

  TextEditingController controllerDate = TextEditingController(
    text: DateFormat("yyyy-MM-dd").format(DateTime.now()),
  );

  TextEditingController controllerStartTime = TextEditingController(
    text: "09:08 PM",
  );

  TextEditingController controllerEndTime = TextEditingController(
    text: "09:08 PM",
  );

  int iconIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.model != null) {
      print(widget.model!.id);
      controllertitle = TextEditingController(text: widget.model!.title);
      controllerDescription.text = widget.model?.description! ?? "";
      controllerDate.text = widget.model?.date ?? "";
      controllerStartTime.text = widget.model?.startTime ?? "";
      controllerEndTime.text = widget.model?.endTime ?? "";
      iconIndex = widget.model?.color ?? 0;
      iconIndex = widget.model!.color;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    controllertitle.dispose();
    controllerDescription.dispose();
    controllerDate.dispose();
    controllerStartTime.dispose();
    controllerEndTime.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: CustomElevatedButton(
          text: "Create Task",
          onPressed: () {
            var id = controllerDate.text; //DateTime.now().toString();

            if (widget.model != null) {
              widget.model!.copyModel(
                title: controllertitle.text,
                description: controllerDescription.text,
                date: controllerDate.text,
                startTime: controllerStartTime.text,
                endTime: controllerEndTime.text,
                color: iconIndex,
              );
              KHive.pushTaskModel(widget.model!.id, widget.model!);
            } else {
              KHive.pushTaskModel(
                id,
                TaskModel(
                  id: id,
                  title: controllertitle.text,
                  description: controllerDescription.text,
                  date: controllerDate.text,
                  startTime: controllerStartTime.text,
                  endTime: controllerEndTime.text,
                  color: iconIndex,
                ),
              );
            }

            Navigator.pushReplacementNamed(context, "B");
          },
          horozantialPadding: 16,
        ),
      ),
      appBar: AppBar(
        foregroundColor: Kcolors.maiColor,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          "Add Task",
          style: Kfonts.textStyle(
            color: Kcolors.maiColor,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Title",
                style: Kfonts.textStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Gap(5),
              CustomTextFormField(
                hint: "Enter title",
                controller: controllertitle,
              ),
              Gap(10),
              Text(
                "Description",
                style: Kfonts.textStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Gap(5),
              CustomTextFormField(
                hint: "Enter description",
                maxLines: 3,
                controller: controllerDescription,
              ),
              Gap(10),
              Text(
                "Date",
                style: Kfonts.textStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Gap(5),
              CustomTextFormField(
                onTap: () async {
                  var Result = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2025),
                    lastDate: DateTime(2050),
                  );
                  if (Result != null) {
                    setState(() {
                      controllerDate.text = DateFormat(
                        "yyyy-MM-dd",
                      ).format(Result);
                    });
                  }
                },
                suffixIcon: Icon(Icons.date_range_outlined),
                controller: controllerDate,
                readOnly: true,
              ),
              Gap(10),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Start Time",
                          style: Kfonts.textStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Gap(5),
                        CustomTextFormField(
                          onTap: () async {
                            var Result = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            result(Result, controllerStartTime);
                          },
                          suffixIcon: Icon(Icons.date_range_outlined),
                          controller: controllerStartTime,
                          readOnly: true,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "End Time",
                          style: Kfonts.textStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Gap(5),
                        CustomTextFormField(
                          onTap: () async {
                            var Result = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            result(Result, controllerEndTime);
                          },
                          suffixIcon: Icon(Icons.date_range_outlined),
                          controller: controllerEndTime,
                          readOnly: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Gap(10),
              Text(
                "Color",
                style: Kfonts.textStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Gap(10),
              Row(
                spacing: 8,
                children: List.generate(3, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        iconIndex = index;
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: color[index],
                      child: iconIndex == index
                          ? Icon(Icons.check, color: Kcolors.white)
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

  void result(dynamic Result, dynamic controller) {
    if (Result != null) {
      setState(() {
        controller.text = Result.format(context);
      });
    }
  }
}

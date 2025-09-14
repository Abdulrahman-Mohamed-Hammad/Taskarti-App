import 'dart:developer';
import 'dart:io';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:taskarti/Widget/widget.dart';
import 'package:taskarti/feature/AddTask.dart';
import 'package:taskarti/hive/hive.dart';
import 'package:taskarti/utils/ConstantFonts.dart';
import 'package:taskarti/utils/ConstantsColors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var date = DateFormat("yyyy-MM-dd").format(DateTime.now());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // image =await KHive.popUserBox(KHive.imageKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              CustomRow(
                row: [
                  Text(
                    KHive.popUserBox(KHive.nameKey),
                    style: Kfonts.textStyle(
                      color: Kcolors.maiColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Have A Nice Day.",
                    style: Kfonts.textStyle(fontSize: 12),
                  ),
                ],
                w: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "D");
                  },
                  child: CircleAvatar(
                    backgroundImage: FileImage(
                      File(KHive.popUserBox(KHive.imageKey)),
                    ),
                  ),
                ),
              ),
              Gap(20),
              CustomRow(
                row: [
                  Text(
                    "October 30 ,2023",
                    style: Kfonts.textStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Today.",
                    style: Kfonts.textStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                w: CustomElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "C");
                  },
                  text: "+ Add Task",
                  horozantialPadding: 0,
                  width: 110,
                ),
              ),
              const Gap(10),
              DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: Kcolors.maiColor,
                onDateChange: (selectedDate) {
                  setState(() {
                    date =selectedDate.toString();
                    print(date);
                  });
                },
                height: 90,
                width: 80
              ),
              const Gap(30),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: KHive.taskModel.listenable(),
                  
                  // var z = KHive.taskModel.values;
                  builder: (context, box, child) {
                    List  x =[];
                for (var i in box.values) {
                   if(i.id.split(" ")[0] == date.split(" ")[0] ){
                   x.add(i);
                   }
                  
                }

                    List<dynamic> z = KHive.taskModel.values.toList();
                    log(z[0].id);
                    return ListView.builder(
                      itemCount: x.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.all(10),
                          height: 120,
                          decoration: BoxDecoration(
                            color: color[x[index].color],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  spacing: 10,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        x[index].title ?? " ",
                                        style: Kfonts.textStyle(
                                          color: Kcolors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(spacing: 20,
                                        children: [
                                          Icon(
                                            Icons.access_time_sharp,
                                            color: Kcolors.white,
                                            size: 15,
                                          ),
                                          Text(
                                            "${x[index].startTime} - ${x[index].endTime}",
                                            style: Kfonts.textStyle(
                                              color: Kcolors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        x[index].description,
                                        style: Kfonts.textStyle(
                                          color: Kcolors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 50,
                                color: Kcolors.white,
                              ),
                              const Gap(10),
                              RotatedBox(quarterTurns: 3, child: Text("ToDo",                                      style: Kfonts.textStyle(
                                          color: Kcolors.white,
                                          fontSize: 16,
                                        ),)),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  const CustomRow({super.key, required this.row, required this.w});
  final List<Widget> row;
  final Widget w;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: row),
        w,
      ],
    );
  }
}

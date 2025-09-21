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
import 'package:taskarti/hive/modelTask.dart';
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
                z: IconButton(onPressed:(){
                 if(KHive.popUserBox(KHive.themeModeKey) == null ){
                  KHive.pushUserBox(KHive.themeModeKey,true);
                 }
                 else{
                   KHive.pushUserBox(KHive.themeModeKey,null);
                 }
                  
                }, icon: Icon(Icons.dark_mode)),
                w:InkWell(
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
                z: SizedBox(),
              ),
              const Gap(10),
              DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: Kcolors.maiColor,
                dayTextStyle: Kfonts.textStyle(fontSize: 12) ?? TextStyle() ,
                dateTextStyle:Kfonts.textStyle(fontSize: 24) ?? TextStyle() ,
                monthTextStyle: Kfonts.textStyle(fontSize: 12) ?? TextStyle(),
                
            
                onDateChange: (selectedDate) {
                  setState(() {
                    date = selectedDate.toString();
                    print(date);
                  });
                },
                height: 90,
                width: 80,
              ),
              const Gap(30),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: KHive.taskModel.listenable(),

                  // var z = KHive.taskModel.values;
                  builder: (context, box, child) {
                    List<TaskModel> x = [];
                    for (var i in box.values) {
                      if (i.date.split(" ")[0] == date.split(" ")[0]) {
                        x.add(i);
                      }
                    }

                    return ListView.builder(
                      itemCount: x.length,
                      itemBuilder: (context, index) {
                        log("aaaaaaaaa");

                        return Dismissible(
                          key: Key(x[index].id),
                          background: ContinerSweap(text: "Complete", aligment: Alignment.centerLeft,color: Colors.green,),
                          secondaryBackground: ContinerSweap(text: "Delete Task", aligment: Alignment.centerRight,color: Kcolors.red,),
                          direction: DismissDirection.horizontal,
                          onDismissed: (direction) {

                            if(direction == DismissDirection.endToStart)
                            {
                             KHive.deletTaskModel(x[index].id);
                            }
  
                         
                          },
                          confirmDismiss: (direction)async {
                            if(direction == DismissDirection.startToEnd){
                             x[index].copyModel(isComplete: true,color: 3);
                             KHive.pushTaskModel(x[index].id, x[index]);
                             return false;
                            }
                            return true;
                          },

                          child: GestureDetector(
                            onTap: () {
                              if (x[index] != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AddTask(model: x[index]),
                                  ),
                                );
                              } // print("vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv${x[index].title}");
                            },
                            child: Container(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          child: Row(
                                            spacing: 20,
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
                                            x[index].description ?? "",
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
                                  RotatedBox(
                                    quarterTurns: 3,
                                    child: Text(
                                      x[index].isComplete == true ? "is Complete " :"ToDO",
                                      style: Kfonts.textStyle(
                                        color: Kcolors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
  const CustomRow({super.key, required this.row, required this.w,required this.z });
  final List<Widget> row;
  final Widget w;
  final Widget z ;
  @override
  Widget build(BuildContext context) {
    return Row(
      
      children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: row)),
        z,
        w,
        
      ],
    );
  }
}


class ContinerSweap extends StatelessWidget {
  const ContinerSweap({super.key, this.color, required this.text, required this.aligment});

   final Color? color;
   final String text;
   final AlignmentGeometry aligment;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(width: 10,height: 120,
                              decoration: BoxDecoration(color: color,borderRadius: BorderRadius.circular(16)),
                              child: Align(
                                alignment: aligment,
                                child: Padding(
                                  padding: EdgeInsetsGeometry.only(right: 20,left: 20),
                                  child: Text(text,style: Kfonts.textStyle(color: Kcolors.white),),
                                ),
                              ),
                            ),
    );
  }
}
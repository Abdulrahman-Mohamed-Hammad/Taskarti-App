






import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskarti/Widget/widget.dart';
import 'package:taskarti/utils/ConstantFonts.dart';
import 'package:taskarti/utils/ConstantsColors.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [

              CustomRow(row: [  Text("Hello,Sayed",style: Kfonts.textStyle(color: Kcolors.maiColor,fontWeight: FontWeight.w600,fontSize: 16),),Text("Have A Nice Day.",style: Kfonts.textStyle(fontSize: 12),)], w: CircleAvatar())
          ,Gap(20),
          CustomRow(row: [Text("October 30 ,2023",style: Kfonts.textStyle(fontWeight: FontWeight.w600,fontSize: 16),),Text("Today.",style: Kfonts.textStyle(fontSize: 16,fontWeight:FontWeight.w600 ),)], w: CustomElevatedButton(onPressed: () {
            Navigator.pushNamed(context, "C");
          },text: "+ Add Task",horozantialPadding: 0,width: 110,))
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
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: row
                  
                ),
               w
              ],);
  }
}
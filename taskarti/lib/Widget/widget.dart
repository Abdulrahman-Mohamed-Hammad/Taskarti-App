import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:taskarti/utils/ConstantsColors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;

  final VoidCallback onPressed;
  final double horozantialPadding;
  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.horozantialPadding,this.width =double.infinity,this.height=48
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:width,
      height: height,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horozantialPadding),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Kcolors.maiColor,
            foregroundColor: Kcolors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              
            ),padding: EdgeInsets.all(0)
          ),
          onPressed: onPressed,
          child: Text(text),
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({super.key, this.controller, this.hint="",this.maxLines=1, this.suffixIcon,this.readOnly=false});
  final int maxLines;
 final String hint;
 final Widget? suffixIcon;
 final bool readOnly ; 
  final InputBorder? inputBorder =  OutlineInputBorder(borderRadius: BorderRadius.circular(10,),borderSide: BorderSide(color: Kcolors.maiColor));
final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(controller: controller,
        decoration: InputDecoration(hintText: hint,
        border: inputBorder,
          enabledBorder: inputBorder,
          focusedBorder:inputBorder,
         suffixIcon: suffixIcon
        ),
        readOnly:readOnly ,
        maxLines: maxLines,
    );
  }
}
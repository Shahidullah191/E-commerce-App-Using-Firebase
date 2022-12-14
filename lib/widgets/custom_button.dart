import 'package:ecommerce/const/app_color.dart';
import 'package:ecommerce/widgets/custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customButton (String buttonText, onTap){
  return SizedBox(
    width: 1.sw,
    height: 56.h,
    child: InkWell(
      onTap: onTap,
      child: Container(
        height: 56.h,
        child: Center(
            child: Text(
              buttonText,
              style: myStyle(
                  20.sp,
                  Colors.white,
                  FontWeight.w700),
            )),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xff5660CD),
            Color(0xff7B81EC),
          ]),
          borderRadius: BorderRadius.circular(50.r),
        ),
      ),
    ),
  );
}
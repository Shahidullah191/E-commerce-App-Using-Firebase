import 'dart:async';

import 'package:ecommerce/const/app_color.dart';
import 'package:ecommerce/screens/login_screen.dart';
import 'package:ecommerce/widgets/custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(Duration(seconds: 3), () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginScreen())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kbgcolor,

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset("assets/ecommerce.json"),

          Text("Welcome to My",
            style: myStyle(40.sp, Colors.white, FontWeight.w700),),
          Text("E-commerce",
            style: myStyle(40.sp, Colors.white, FontWeight.bold),),

        ],
      ),
    );
  }
}


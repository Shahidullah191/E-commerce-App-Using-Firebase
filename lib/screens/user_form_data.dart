import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/const/app_color.dart';
import 'package:ecommerce/screens/bottom_nav_bar.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:ecommerce/widgets/custom_textfield.dart';
import 'package:ecommerce/widgets/custom_textstyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

List<String> gender = ["Male", "Female", "Other"];

class UserFormData extends StatefulWidget {
  const UserFormData({Key? key}) : super(key: key);

  @override
  State<UserFormData> createState() => _UserFormDataState();
}

class _UserFormDataState extends State<UserFormData> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  String dropdownValue = gender.first;

  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 50),
      lastDate: DateTime.now(),
    );
    if (picked != null)
      setState(() {
        _dobController.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
  }

  sendUserDataToDB() {

    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("user-form-data");

    return _collectionRef.doc(currentUser!.email).set({
      "name": _nameController.text,
      "phone": _phoneController.text,
      "dob": _dobController.text,
      "gender": _genderController.text,
      "age": _ageController.text,
    }).then((value) => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BottomNavBar(),
        ))).catchError((error)=> Fluttertoast.showToast(msg: "something is wrong. $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.only(
          top: 15.h,
          left: 15.w,
          right: 15.w,
        ),
        child: ListView(
          children: [
            Text(
              "Submit the form to continue",
              style: myStyle(25.sp, AppColor.kbgcolor, FontWeight.w700),
            ),
            Text(
              "We will not share your information with anyone",
              style: myStyle(16.sp, Colors.black54, FontWeight.w400),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 50.h,
                bottom: 15.h,
              ),
              child: CustomTextField(
                Controller: _nameController,
                keyBoardType: TextInputType.emailAddress,
                icon: Icons.person_outline_outlined,
                labelText: "Full Name",
              ),
            ),
            CustomTextField(
              Controller: _phoneController,
              keyBoardType: TextInputType.emailAddress,
              icon: Icons.phone,
              labelText: "Phone Number",
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 15.h,
                bottom: 15.h,
              ),
              child: TextField(
                controller: _dobController,
                readOnly: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 3.w, color: Color(0xff7B81EC)),
                    borderRadius: BorderRadius.circular(50.0.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 3.w, color: Color(0xff7B81EC)),
                    borderRadius: BorderRadius.circular(50.0.r),
                  ),
                  labelText: "Date of birth",
                  labelStyle:
                      myStyle(20.sp, Color(0xff7B81EC), FontWeight.bold),
                  //prefixIcon: Icon(Icons.calendar_today_outlined, color: Color(0xff7B81EC),),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _selectDateFromPicker(context);
                    },
                    icon: Icon(
                      Icons.calendar_today_outlined,
                      color: Color(0xff7B81EC),
                    ),
                  ),
                ),
              ),
            ),
            TextFormField(
              readOnly: true,
              controller: _genderController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3.w, color: Color(0xff7B81EC)),
                  borderRadius: BorderRadius.circular(50.0.r),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3.w, color: Color(0xff7B81EC)),
                  borderRadius: BorderRadius.circular(50.0.r),
                ),
                labelText: "Gender",
                labelStyle: myStyle(20.sp, Color(0xff7B81EC), FontWeight.bold),
                //prefixIcon: Icon(Icons.calendar_today_outlined, color: Color(0xff7B81EC),),
                suffixIcon: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_drop_down_sharp),
                  elevation: 16,
                  style: const TextStyle(color: AppColor.kbgcolor),
                  // underline: Container(
                  //   height: 2,
                  //   color: Colors.deepPurpleAccent,
                  // ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      _genderController.text = value!;
                    });
                  },
                  items: gender.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: myStyle(18, AppColor.kbgcolor),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 15.h,
              ),
              child: CustomTextField(
                Controller: _ageController,
                keyBoardType: TextInputType.emailAddress,
                icon: Icons.person_outline_outlined,
                labelText: "Age",
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 190.h,
              ),
              child: customButton("Continue", () {
                sendUserDataToDB();
              }),
            ),
          ],
        ),
      ),
    ));
  }
}

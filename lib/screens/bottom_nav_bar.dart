import 'package:ecommerce/const/app_color.dart';
import 'package:ecommerce/screens/bottom_nav_pages/cart.dart';
import 'package:ecommerce/screens/bottom_nav_pages/favourite.dart';
import 'package:ecommerce/screens/bottom_nav_pages/home.dart';
import 'package:ecommerce/screens/bottom_nav_pages/profile.dart';
import 'package:ecommerce/widgets/custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final pages = [HomePage(), FavouritePage(), CartPage(), ProfilePage()];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent.withOpacity(0.2),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "E-Commerce",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: myStyle(16.sp, Colors.white),
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
            backgroundColor: AppColor.kbgcolor,
          ),
          BottomNavigationBarItem(
            label: "Favourite",
            icon: Icon(Icons.favorite),
            backgroundColor: AppColor.kbgcolor,
          ),
          BottomNavigationBarItem(
            label: "Cart",
            icon: Icon(Icons.add_shopping_cart),
            backgroundColor: AppColor.kbgcolor,
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.person),
            backgroundColor: AppColor.kbgcolor,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),

      body: pages[_currentIndex],
    );
  }
}

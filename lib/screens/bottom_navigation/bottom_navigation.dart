import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/screens/home/home_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.house),
      activeIcon: Icon(CupertinoIcons.house_fill), // <- icon đen khi chọn
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        CupertinoIcons.search,
        size: 24,
        color: Colors.black.withOpacity(0.8),
      ),
      activeIcon: Icon(CupertinoIcons.search, size: 24, color: Colors.black),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.add_circled),
      activeIcon: Icon(CupertinoIcons.add_circled_solid),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.play_rectangle),
      activeIcon: Icon(CupertinoIcons.play_rectangle_fill),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: CircleAvatar(
        radius: 12,
        backgroundImage: AssetImage("images/avt.jpg"),
      ),
      activeIcon: CircleAvatar(
        radius: 12,
        backgroundColor: Colors.black, // vòng đen bao quanh
        child: CircleAvatar(
          radius: 10,
          backgroundImage: AssetImage("images/avt.jpg"),
        ),
      ),
      label: '',
    ),
  ];

  List<Widget> pages = [HomeScreen()];
  var indexPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: IndexedStack(index: indexPage, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: items,
        currentIndex: indexPage,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        onTap: (index) {
          setState(() {
            indexPage = index;
          });
        },
      ),
    );
  }
}

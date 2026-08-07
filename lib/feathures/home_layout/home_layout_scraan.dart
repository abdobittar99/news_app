import 'package:flutter/material.dart';
import 'package:news_app/feathures/bookmark/bookmark_Screen.dart';
import 'package:news_app/feathures/home/home_screen.dart';
import 'package:news_app/feathures/profile/profile_screen.dart';
import 'package:news_app/feathures/search/search_screen.dart';

class HomeLayoutScraan extends StatefulWidget {
  const HomeLayoutScraan({super.key});

  @override
  State<HomeLayoutScraan> createState() => _HomeLayoutScraanState();
}

class _HomeLayoutScraanState extends State<HomeLayoutScraan> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    BookmarkScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border_outlined),
            label: "Bookmark",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined),
            label: "Profile",
          ),
        ],
      ),
      body: _screens[_currentIndex],
    );
  }
}

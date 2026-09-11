import 'package:flutter/material.dart';
import 'package:news_app/feathures/bookmark/bookmark_Screen.dart';
import 'package:news_app/feathures/bookmark/data/bookmark_repository.dart';
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
  int _bookmarkCount = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    BookmarkScreen(),
    ProfileScreen(),
  ];
  @override
  void initState() {
    super.initState();
    _updateBookmarkCount();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update bookmark count when screen becomes visible
    _updateBookmarkCount();
  }

  void _updateBookmarkCount() {
    setState(() {
      _bookmarkCount = BookmarkRepository().getBookmarkCount();
    });
  }

  Widget _buildBookmarkIcon() {
    if (_bookmarkCount == 0) {
      return const Icon(Icons.bookmark_border);
    }

    return Badge(
      label: Text(_bookmarkCount.toString()),
      child: const Icon(Icons.bookmark_border),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
          if (_currentIndex == 2) {
            _updateBookmarkCount();
          }
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
            icon: _buildBookmarkIcon(),
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

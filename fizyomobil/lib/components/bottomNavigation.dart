import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fizyomobil/pages/exams.dart';
import 'package:fizyomobil/pages/favourites.dart';
import 'package:fizyomobil/pages/homepage.dart';
import 'package:fizyomobil/pages/models.dart';
import 'package:fizyomobil/pages/settings.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    exams(),
    const Models(),
    const favs(),
    const settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        backgroundColor: const Color.fromARGB(255, 234, 234, 234),
        buttonBackgroundColor: Theme.of(context).primaryColorDark,
        animationDuration: const Duration(milliseconds:300),
        color: Theme.of(context).primaryColorDark,
        items: const [
          Icon(Icons.home, size: 32, color: Colors.white),
          Icon(Icons.menu_book_rounded, size: 32, color: Colors.white),
          Icon(Icons.model_training, size: 32, color: Colors.white),
          Icon(Icons.star_rounded, size:32, color: Colors.white),
          Icon(Icons.settings_outlined, size: 32, color: Colors.white),
        ],
        onTap: _onItemTapped,
      ),
      body: Center(
        child: _pages[_selectedIndex],
      ),
    );
  }
}

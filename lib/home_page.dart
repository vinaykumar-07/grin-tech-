import 'package:flutter/material.dart';
import 'package:grin_tech/page_1.dart';
import 'package:grin_tech/page_2.dart';
import 'package:grin_tech/page_3.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // To track the selected tab index

  // List of widgets corresponding to each tab in the bottom navigation bar
  static const List<Widget> _widgetOptions = <Widget>[
    Page1(),
    Page2(),
    Page3(),
  ];

  // Function to handle tab selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Page 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_add),
            label: 'Page 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_add_check),
            label: 'Page 3',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF012B5B),
        onTap: _onItemTapped,
      ),
    );
  }
}

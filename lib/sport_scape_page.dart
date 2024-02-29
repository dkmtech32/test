import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/pages/booking_page.dart';
import 'package:flutter_app/pages/home_page.dart';

class NavBarBottom extends State<NavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    // Your screens/widgets for each navigation item
    HomePage(),
    BookingPage(),
    const Center(child: Text('Bell')),
    const Center(child: Text('Menu')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          body: _pages[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color.fromARGB(255, 20, 31, 50),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle),
                label: 'Book',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Noti',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: 'Menu',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Color.fromARGB(255, 21, 134, 209),
            onTap: _onItemTapped,
          ),
        ));
  }
}

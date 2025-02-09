import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class CustomNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      color: Colors.deepOrangeAccent,
      buttonBackgroundColor: Colors.black45,
      height: 65,
      animationDuration: const Duration(milliseconds: 300),
      items: [
        Icon(Icons.home, size: 30, color: widget.selectedIndex == 0 ? Colors.white : Colors.black54),
        Icon(Icons.library_books, size: 30, color: widget.selectedIndex == 1 ? Colors.white : Colors.black54),
        Icon(Icons.quiz, size: 30, color: widget.selectedIndex == 2 ? Colors.white : Colors.black54),
        Icon(Icons.person, size: 30, color: widget.selectedIndex == 3 ? Colors.white : Colors.black54),
      ],
      onTap: widget.onItemTapped,
    );
  }
}

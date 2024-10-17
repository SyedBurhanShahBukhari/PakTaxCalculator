import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  CustomBottomNavBar({required this.selectedIndex, required this.onItemTapped});

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 6.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(icon: Icon(Icons.home), onPressed: () => widget.onItemTapped(0)),
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () => widget.onItemTapped(1)),
          SizedBox(width: 48),  // Placeholder for the middle FAB
          IconButton(icon: Icon(Icons.notifications), onPressed: () => widget.onItemTapped(2)),
          IconButton(icon: Icon(Icons.person), onPressed: () => widget.onItemTapped(3)),
        ],
      ),
    );
  }
}

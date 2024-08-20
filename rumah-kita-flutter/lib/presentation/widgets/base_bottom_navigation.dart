import 'package:flutter/material.dart';

import '../../utils/themes.dart';

/// BaseBottomNavigationBar
class BaseBottomNavigationBar extends StatefulWidget {
  final ValueChanged<int>? onTabChange;
  final int initialIndex;

  const BaseBottomNavigationBar({
    super.key,
    this.onTabChange,
    required this.initialIndex,
  });

  @override
  State<BaseBottomNavigationBar> createState() =>
      _BaseBottomNavigationBarState();
}

class _BaseBottomNavigationBarState extends State<BaseBottomNavigationBar> {
  late int _selectedIndex;

  void _onSelectedTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onTabChange?.call(index);
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: cDarkBlue,
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: IconButton(
              onPressed: () {
                _onSelectedTab(0);
              },
              tooltip: 'Inbox',
              icon: Icon(
                Icons.all_inbox,
                size: 32.0,
                color: _selectedIndex == 0 ? cWhite : cWhite.withOpacity(.5),
              ),
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () {
                _onSelectedTab(1);
              },
              tooltip: 'Dashboard',
              icon: Icon(
                Icons.home_rounded,
                size: 32.0,
                color: _selectedIndex == 1 ? cWhite : cWhite.withOpacity(.5),
              ),
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () {
                _onSelectedTab(2);
              },
              tooltip: 'Profile',
              icon: Icon(
                Icons.person_pin,
                size: 32.0,
                color: _selectedIndex == 2 ? cWhite : cWhite.withOpacity(.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

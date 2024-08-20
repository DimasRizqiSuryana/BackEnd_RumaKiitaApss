import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/base_bottom_navigation.dart';

/// HomeLayout
class HomeLayout extends StatelessWidget {
  final Widget child;

  const HomeLayout({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return _HomeLayout(key: key, child: child);
  }
}

class _HomeLayout extends StatefulWidget {
  final Widget child;

  const _HomeLayout({
    super.key,
    required this.child,
  });

  @override
  State<_HomeLayout> createState() => __HomeLayoutState();
}

class __HomeLayoutState extends State<_HomeLayout> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: widget.child,
      ),
      bottomNavigationBar: BaseBottomNavigationBar(
        initialIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });

          if (index == 0) {
            context.go('/inbox-kegiatan');
          } else if (index == 1) {
            context.go('/dashboard');
          } else if (index == 2) {
            context.go('/profile');
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../themes/app_colors.dart';

class TopNavigation extends StatelessWidget {
  final int selectedIndex;

  const TopNavigation({
    super.key,
    required this.selectedIndex,
  });

  void _navigate(BuildContext context, int index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/like');
    }

    if (index == 1) {
      Navigator.pushReplacementNamed(context, '/matches');
    }

    if (index == 2) {
      Navigator.pushReplacementNamed(context, '/messages');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _NavigationItem(
          icon: Icons.thumb_up,
          title: 'Like or Not',
          selected: selectedIndex == 0,
          onTap: () => _navigate(context, 0),
        ),

        _NavigationItem(
          icon: Icons.settings,
          title: 'Matches',
          selected: selectedIndex == 1,
          onTap: () => _navigate(context, 1),
        ),

        _NavigationItem(
          icon: Icons.chat_bubble,
          title: 'Messages',
          selected: selectedIndex == 2,
          onTap: () => _navigate(context, 2),
        ),

        Container(
          width: 55,
          height: 70,
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: Colors.grey),
            ),
          ),
          child: const Icon(
            Icons.person,
            size: 30,
          ),
        ),
      ],
    );
  }
}

class _NavigationItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _NavigationItem({
    required this.icon,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 70,
          color: selected ? AppColors.orange : Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: selected ? Colors.white : Colors.grey,
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: selected ? Colors.white : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
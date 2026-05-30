import 'package:flutter/material.dart';

class AppBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  static const Color _navy = Color(0xFF102B53);

  static const List<_NavItem> _items = [
    _NavItem(icon: Icons.home_rounded, label: 'Home'),
    _NavItem(icon: Icons.search_rounded, label: 'Search'),
    _NavItem(icon: Icons.compare_arrows_rounded, label: 'Compare'),
    _NavItem(icon: Icons.chat_bubble_rounded, label: 'Chat'),
    _NavItem(icon: Icons.person_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final w = constraints.maxWidth;
      final iconSize = (w * 0.065).clamp(20.0, 28.0);
      final iconSizeSelected = (w * 0.075).clamp(22.0, 30.0);
      final fontSize = (w * 0.025).clamp(9.0, 12.0);
      final navHeight = (w * 0.18).clamp(60.0, 75.0);

      return Container(
        height: navHeight,
        decoration: const BoxDecoration(
          color: _navy,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_items.length, (i) {
            final selected = selectedIndex == i;
            return GestureDetector(
              onTap: () => onTap(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: w * 0.03,
                  vertical: 6,
                ),
                decoration: selected
                    ? BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(12),
                      )
                    : null,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _items[i].icon,
                      color: selected ? Colors.white : Colors.white60,
                      size: selected ? iconSizeSelected : iconSize,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      _items[i].label,
                      style: TextStyle(
                        color: selected ? Colors.white : Colors.white60,
                        fontSize: fontSize,
                        fontWeight: selected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      );
    });
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}
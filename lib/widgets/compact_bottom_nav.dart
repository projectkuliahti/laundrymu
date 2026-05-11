// lib/widgets/compact_bottom_nav.dart
import 'package:flutter/material.dart';

class CompactBottomNav extends StatelessWidget {
  final ValueNotifier<int> currentIndexNotifier;
  final List<BottomNavItem> items;
  final Function(int)? onItemTapped;

  const CompactBottomNav({
    super.key,
    required this.currentIndexNotifier,
    required this.items,
    this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color(0xFF3B499A),
      shape: const CircularNotchedRectangle(),
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ValueListenableBuilder<int>(
          valueListenable: currentIndexNotifier,
          builder: (context, currentIndex, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final isActive = index == currentIndex;
                return GestureDetector(
                  onTap: () {
                    if (onItemTapped != null) {
                      onItemTapped!(index);
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        isActive ? item.activeIcon : item.inactiveIcon,
                        width: 24,
                        height: 24,
                        fit: BoxFit.contain,
                        color: isActive ? Colors.white : Colors.white70,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isActive ? Colors.white : Colors.white70,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}

class BottomNavItem {
  final String activeIcon;
  final String inactiveIcon;
  final String label;

  BottomNavItem({
    required this.activeIcon,
    required this.inactiveIcon,
    required this.label,
  });
}
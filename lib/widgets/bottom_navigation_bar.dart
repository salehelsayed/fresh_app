import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  
  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.wifi),
          label: 'Scan',
        ),
        NavigationDestination(
          icon: Icon(Icons.adjust_outlined),
          label: 'Channels',
        ),
        NavigationDestination(
          icon: Icon(Icons.wifi_tethering),
          label: 'Feed',
        ),
        NavigationDestination(
          icon: Icon(Icons.attach_money),
          label: 'Tokens',
        ),
        NavigationDestination(
          icon: Icon(Icons.settings_input_antenna),
          label: 'Connectivity',
        ),
      ],
      selectedIndex: currentIndex,
      onDestinationSelected: (int index) {
        // Don't navigate if we're already on the selected page
        if (index == currentIndex) return;

        // Handle navigation using GoRouter
        switch (index) {
          case 0: // Scan
            context.go('/');
            break;
          case 1: // Channels
            context.go('/channels');
            break;
          case 2: // Feed
            context.go('/feed');
            break;
          case 3: // Tokens
            context.go('/tokens');
            break;
          case 4: // Connectivity
            context.go('/connectivity');
            break;
        }
      },
    );
  }
}

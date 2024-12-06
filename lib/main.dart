import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'providers/channel_provider.dart';
import 'screens/scan_page.dart';
import 'screens/channels_page.dart';
import 'screens/feed_page.dart';
import 'screens/tokens_page.dart';
import 'screens/connectivity_page.dart';
import 'screens/filter_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const ScanPage(),
        ),
        GoRoute(
          path: '/channels',
          builder: (context, state) => const ChannelsPage(),
        ),
        GoRoute(
          path: '/feed',
          builder: (context, state) {
            final extra = state.extra as Map<String, String>?;
            return FeedPage(
              channelId: extra?['channelId'] ?? '',
              channelName: extra?['channelName'] ?? 'Feed',
            );
          },
        ),
        GoRoute(
          path: '/tokens',
          builder: (context, state) => const TokensPage(),
        ),
        GoRoute(
          path: '/connectivity',
          builder: (context, state) => const ConnectivityPage(),
        ),
        GoRoute(
          path: '/filter',
          builder: (context, state) => const FilterPage(),
        ),
        GoRoute(
          path: '/filter',
          builder: (context, state) => const FilterPage(),
        ),
      ],
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChannelProvider()..loadMockChannels()),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Walkie Talkie Social',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          navigationBarTheme: NavigationBarThemeData(
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            height: 80,
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

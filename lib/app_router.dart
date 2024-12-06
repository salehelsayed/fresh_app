import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/scan_page.dart';
import 'screens/channels_page.dart';
import 'screens/feed_page.dart';
import 'screens/tokens_page.dart';
import 'screens/connectivity_page.dart';
import 'screens/filter_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) => const ScanPage(),
      ),
      GoRoute(
        path: '/channels',
        builder: (BuildContext context, GoRouterState state) => const ChannelsPage(),
      ),
      GoRoute(
        path: '/feed',
        builder: (BuildContext context, GoRouterState state) => const FeedPage(
          channelId: '',
          channelName: 'Feed',
        ),
      ),
      GoRoute(
        path: '/tokens',
        builder: (BuildContext context, GoRouterState state) => const TokensPage(),
      ),
      GoRoute(
        path: '/connectivity',
        builder: (BuildContext context, GoRouterState state) => const ConnectivityPage(),
      ),
      GoRoute(
        path: '/filter',
        builder: (BuildContext context, GoRouterState state) => const FilterPage(),
      ),
    ],
  );
}

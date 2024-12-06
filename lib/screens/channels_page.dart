import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/channel_provider.dart';
import '../models/channel.dart';
import 'feed_page.dart';
import '../widgets/bottom_navigation_bar.dart';
import 'package:go_router/go_router.dart';

class ChannelsPage extends StatelessWidget {
  const ChannelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Channels'),
      ),
      body: Consumer<ChannelProvider>(
        builder: (context, provider, child) {
          final favoriteChannels = provider.favoriteChannels;
          return ListView.builder(
            itemCount: favoriteChannels.length,
            itemBuilder: (context, index) {
              return FavoriteChannelCard(channel: favoriteChannels[index]);
            },
          );
        },
      ),
      bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 1),
    );
  }
}

class FavoriteChannelCard extends StatelessWidget {
  final Channel channel;

  const FavoriteChannelCard({
    super.key,
    required this.channel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: InkWell(
        onTap: () => context.go(
          '/feed',
          extra: {
            'channelId': channel.id,
            'channelName': channel.name,
          },
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    channel.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  IconButton(
                    icon: Icon(
                      channel.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: channel.isFavorite ? Colors.red : null,
                    ),
                    onPressed: () {
                      context.read<ChannelProvider>().toggleFavorite(channel.id);
                    },
                  ),
                ],
              ),
              Text(channel.description),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${channel.activeUsers} active users'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

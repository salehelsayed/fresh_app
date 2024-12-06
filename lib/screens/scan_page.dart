import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/channel_provider.dart';
import '../models/channel.dart';
import 'feed_page.dart';
import '../widgets/bottom_navigation_bar.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => context.push('/filter'),
          ),
        ],
      ),
      body: Consumer<ChannelProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              // Segmented button section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(
                      value: 'friends',
                      icon: Icon(Icons.people),
                      label: Text('Friends & Family'),
                    ),
                    ButtonSegment(
                      value: 'map',
                      icon: Icon(Icons.map),
                      label: Text('Map'),
                    ),
                    ButtonSegment(
                      value: 'work',
                      icon: Icon(Icons.work),
                      label: Text('Work'),
                    ),
                    ButtonSegment(
                      value: 'hashtags',
                      icon: Icon(Icons.tag),
                      label: Text('Hashtags'),
                    ),
                  ],
                  selected: provider.selectedCategories,
                  onSelectionChanged: (Set<String> newSelection) {
                    provider.setSelectedCategories(newSelection);
                  },
                  multiSelectionEnabled: true,
                ),
              ),
              // Channel list
              Expanded(
                child: ListView.builder(
                  itemCount: provider.filteredChannels.length,
                  itemBuilder: (context, index) {
                    if (index < provider.filteredChannels.length) {
                      final channel = provider.filteredChannels[index];
                      return ChannelCard(channel: channel);
                    }
                    return null;
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 0),
    );
  }
}

class ChannelCard extends StatelessWidget {
  final Channel channel;

  const ChannelCard({
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

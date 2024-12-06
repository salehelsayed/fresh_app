import 'package:flutter/foundation.dart';
import '../models/channel.dart';

class ChannelProvider with ChangeNotifier {
  List<Channel> _channels = [];
  Set<String> _selectedCategories = {'friends'};
  List<Channel> _favoriteChannels = [];

  List<Channel> get channels => _channels;
  Set<String> get selectedCategories => _selectedCategories;
  List<Channel> get favoriteChannels => _favoriteChannels;

  List<Channel> get filteredChannels {
    if (_selectedCategories.isEmpty) return _channels;
    return _channels.where((channel) => 
      _selectedCategories.contains(channel.category)
    ).toList();
  }

  void setSelectedCategories(Set<String> categories) {
    _selectedCategories = categories;
    notifyListeners();
  }

  void toggleFavorite(String channelId) {
    final channelIndex = _channels.indexWhere((c) => c.id == channelId);
    if (channelIndex != -1) {
      final channel = _channels[channelIndex];
      _channels[channelIndex] = channel.copyWith(isFavorite: !channel.isFavorite);
      
      if (_channels[channelIndex].isFavorite) {
        _favoriteChannels.add(_channels[channelIndex]);
      } else {
        _favoriteChannels.removeWhere((c) => c.id == channelId);
      }
      
      notifyListeners();
    }
  }

  // Mock data for testing
  void loadMockChannels() {
    _channels = [
      Channel(
        id: '1',
        name: 'Family Chat',
        description: 'Stay connected with family members',
        category: 'friends',
        activeUsers: 5,
        isFavorite: true,  // Set as favorite
      ),
      Channel(
        id: '2',
        name: 'Local Events',
        description: 'Discover events happening near you',
        category: 'map',
        activeUsers: 42,
        isFavorite: true,  // Set as favorite
      ),
      Channel(
        id: '3',
        name: 'Work Updates',
        description: 'Company-wide announcements and updates',
        category: 'work',
        activeUsers: 15,
        isFavorite: false,
      ),
      Channel(
        id: '4',
        name: 'Tech Talk',
        description: 'Discuss the latest in technology',
        category: 'hashtags',
        activeUsers: 28,
        isFavorite: false,
      ),
      Channel(
        id: '5',
        name: 'Friend Group',
        description: 'Chat with your closest friends',
        category: 'friends',
        activeUsers: 8,
        isFavorite: true,  // Set as favorite
      ),
    ];

    // Initialize favorite channels
    _favoriteChannels = _channels.where((channel) => channel.isFavorite).toList();
    notifyListeners();
  }
}

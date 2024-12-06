# Frontend Tasks and Backend Mock Objects

## Frontend Tasks

### Project Setup

#### Project Initialization
- Create new Flutter project
- Configure package structure (core, features, etc.)
- Add dependencies:
  - State management (Riverpod/Bloc)
  - HTTP clients (http/dio)
  - UI libraries

#### Theming & Styling
- Implement global styles in `app_theme.dart`
  - Colors
  - Typography
  - Responsiveness
  - Accessibility

#### Routing & Navigation
- Set up `AppRouter` class
- Define named routes
- Establish navigation flows:
  - Scan → Feed → Channels
  - Future authentication routes

### Common UI Components

#### Bottom Navigation Bar
- Create `CustomBottomNavBar`
  - Navigate between:
    - ScanPage
    - ChannelsPage
    - FeedPage (placeholder)
    - TokensPage
    - ConnectivityPage

#### Segmented Button Widgets
- Implement multi-select toggles for filtering
- Categories:
  - Friends & Family
  - Map
  - Work
  - Hashtags

#### Channel Card Widget
- Display:
  - Name
  - Description
  - Favorite icon
  - Tune-in button
- Handle interactions:
  - Favorite toggle
  - Navigation to feed

#### Message Tile Widget
- Show text messages in chat feed
- Support:
  - Sender info
  - Timestamp
  - Message content

### Feature-Specific UI

#### Scan Page
- Layout:
  - Segmented filter buttons
  - Search bar (optional)
  - Channel cards list
- States:
  - Loading
  - Empty
  - Error
- Integrate with `ScanViewModel`

#### Channels Page
- Display favorite channels
- Use same channel card UI
- Integrate with `ChannelsViewModel`

#### Feed Page
- Implement:
  - Scrolling chat view
  - Text input field
  - Filter button/sheet
  - Back button
- Integrate with `FeedViewModel`

#### Filter Page
- Sections:
  - Whisper/broadcast toggle
  - Friends percentage slider
  - Location filters
  - Work filters
- Buttons:
  - Apply
  - Reset
- Integrate with `FilterViewModel`

#### Placeholder Pages
- Tokens Page:
  - Dollar sign icon
  - Footer navigation
- Connectivity Page:
  - Connectivity icon
  - Footer navigation

## Backend Mock Objects

### Mock Repositories

#### MockChannelRepository
```dart
class MockChannelRepository {
  Future<List<ChannelEntity>> getChannelsFiltered(List<String> filters) async {
    return [
      ChannelEntity(
        id: '1',
        name: 'General Chat',
        description: 'Public discussion',
        isFavorite: false,
        activeUsers: 42
      ),
      ChannelEntity(
        id: '2',
        name: 'Work Updates',
        description: 'Team announcements',
        isFavorite: true,
        activeUsers: 15
      ),
    ];
  }

  Future<void> updateFavoriteStatus(String channelId, bool isFavorite) async {
    print('Channel $channelId favorite status updated to: $isFavorite');
  }
}
```

#### MockFavoriteChannelRepository
```dart
class MockFavoriteChannelRepository {
  final _favorites = <String, bool>{};

  Future<List<ChannelEntity>> getFavoriteChannels() async {
    return [
      ChannelEntity(
        id: '2',
        name: 'Work Updates',
        description: 'Team announcements',
        isFavorite: true,
        activeUsers: 15
      ),
    ];
  }

  Future<void> updateFavoriteStatus(String channelId, bool isFavorite) async {
    _favorites[channelId] = isFavorite;
  }
}
```

#### MockMessageRepository
```dart
class MockMessageRepository {
  final _messages = <String, List<MessageEntity>>{};

  Future<List<MessageEntity>> getMessages(String channelId) async {
    return [
      MessageEntity(
        id: '1',
        channelId: channelId,
        text: 'Hello everyone!',
        sender: 'User1',
        timestamp: DateTime.now().subtract(Duration(minutes: 5))
      ),
      MessageEntity(
        id: '2',
        channelId: channelId,
        text: 'Welcome to the channel!',
        sender: 'User2',
        timestamp: DateTime.now()
      ),
    ];
  }

  Future<void> sendMessage(String channelId, String text) async {
    final message = MessageEntity(
      id: DateTime.now().toString(),
      channelId: channelId,
      text: text,
      sender: 'CurrentUser',
      timestamp: DateTime.now()
    );
    
    _messages[channelId] ??= [];
    _messages[channelId]!.add(message);
  }
}
```

#### MockFilterRepository
```dart
class MockFilterRepository {
  FilterSettingsEntity _settings = FilterSettingsEntity(
    isWhisperMode: false,
    friendsPercentage: 50,
    location: 'All',
    workFilter: 'All'
  );

  Future<FilterSettingsEntity> getFilterSettings() async {
    return _settings;
  }

  Future<void> updateFilterSettings(FilterSettingsEntity settings) async {
    _settings = settings;
  }
}
```

### Mock Data Sources

#### MockChannelRemoteDataSource
```dart
class MockChannelRemoteDataSource {
  Future<List<ChannelModel>> fetchChannels(List<String> filters) async {
    return [
      ChannelModel(
        id: '1',
        name: 'General Chat',
        description: 'Public discussion',
        isFavorite: false,
        activeUsers: 42
      ),
      ChannelModel(
        id: '2',
        name: 'Work Updates',
        description: 'Team announcements',
        isFavorite: false,
        activeUsers: 15
      ),
    ];
  }
}
```

#### MockChannelLocalDataSource
```dart
class MockChannelLocalDataSource {
  final _favoriteChannels = <String, bool>{};

  Future<void> saveFavoriteStatus(String channelId, bool isFavorite) async {
    _favoriteChannels[channelId] = isFavorite;
  }

  Future<List<String>> getFavoriteChannelIds() async {
    return _favoriteChannels.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();
  }
}
```

#### MockMessageRemoteDataSource
```dart
class MockMessageRemoteDataSource {
  Future<List<MessageModel>> fetchMessages(String channelId) async {
    return [
      MessageModel(
        id: '1',
        channelId: channelId,
        text: 'Hello everyone!',
        sender: 'User1',
        timestamp: DateTime.now().subtract(Duration(minutes: 5))
      ),
    ];
  }

  Future<void> sendMessage(String channelId, String text) async {
    print('Message sent to channel $channelId: $text');
  }
}
```

## Testing Strategy

### UI Tests
- Test key pages in isolation
- Use mock data
- Verify filter changes
- Test navigation flows

### Integration Tests
- Test ViewModels with mock repositories
- Verify data flow
- Test error handling

### Mock Data Guidelines
- Use realistic data
- Cover edge cases
- Test different states:
  - Empty
  - Loading
  - Error
  - Success

*Note: These mocks provide a foundation for development. Adjust based on specific needs.*

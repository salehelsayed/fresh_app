# Architecture Overview

## Layers
This architecture follows a clean architecture approach, splitting the code into three primary layers:

### Presentation Layer
Handles the UI and state management.

### Domain Layer
Encapsulates business logic via entities and use cases.

### Data Layer
Manages data retrieval, storage, and mapping to domain models.

## Terminology

* **Page**: A UI screen in Flutter.
* **ViewModel/Bloc/Controller**: A state management class that handles user interactions and communicates with the domain layer.
* **Entity**: A pure business logic model that represents a concept within the app, free from UI or framework details.
* **Use Case**: A class that executes a specific business operation (e.g., "GetFilteredChannels", "SendMessage").
* **Repository**: An abstraction that defines operations to fetch or manipulate data. The domain layer depends on this interface.
* **Data Sources**: Classes that handle data operations (e.g., network calls or local database queries). They implement repository contracts in the data layer.
* **Models**: Data Transfer Objects (DTOs) used by the data layer to serialize/deserialize data from external sources and map to domain entities.

## Example Feature: Scan

### Presentation Layer
#### ScanPage (Widget)

* **Description**: Displays the segmented filters, a search bar, and a list of available channel cards.
* **Key Functions**:
	+ `build(BuildContext context)`: Renders UI components.
	+ Initiates fetching of channels via the ScanViewModel.
* **Expected Calls**:
	+ `scanViewModel.loadChannels(filters)`: Fetch the filtered channels.
	+ `scanViewModel.toggleFavoriteChannel(channel)`: Mark/unmark a channel as favorite.

#### ScanViewModel (State Management)

* **Description**: Manages state and logic for the ScanPage. Holds the current list of channels, selected filters, and handles user actions.
* **Key Functions**:
	+ `loadChannels(List<String> filters)`: Requests filtered channels from the domain layer.
	+ `toggleFilter(String filter)`: Adds or removes a filter, then reloads channels.
	+ `toggleFavoriteChannel(ChannelEntity channel)`: Updates the favorite status of a channel.
* **Expected Calls**:
	+ `getFilteredChannelsUseCase.execute(filters)`: Fetch channels from the domain.
	+ `favoriteChannelUseCase.execute(channel)`: Update favorites in the domain.

## Domain Layer

### ChannelEntity

* **Description**: Represents a channel in business logic. Contains fields like id, name, description, isFavorite.
* **Properties**:
	+ `id`: Unique identifier
	+ `name`: Channel name
	+ `description`: Channel description
	+ `isFavorite`: Boolean indicating if it’s a favorite channel
* **No direct functions** (usually just data).

### GetFilteredChannels (Use Case)

* **Description**: Retrieves a list of channels matching given filters.
* **Key Functions**:
	+ `execute(List<String> filters) -> Future<List<ChannelEntity>>`
* **Expected Calls**:
	+ `channelRepository.getChannelsFiltered(filters)`: Fetch channels from the repository.

### FavoriteChannel (Use Case)

* **Description**: Marks a given channel as favorite or removes it from favorites.
* **Key Functions**:
	+ `execute(ChannelEntity channel, bool isFavorite) -> Future<void>`
* **Expected Calls**:
	+ `channelRepository.updateFavoriteStatus(channel.id, isFavorite)`: Update channel favorite status in the repository.

## Data Layer

### ChannelRepositoryImpl

* **Description**: Implementation of the ChannelRepository interface. Bridges the domain use cases with data sources.
* **Key Functions**:
	+ `getChannelsFiltered(List<String> filters) -> Future<List<ChannelEntity>>`
	+ `updateFavoriteStatus(String channelId, bool isFavorite) -> Future<void>`
* **Expected Calls**:
	+ `channelRemoteDataSource.fetchChannels(filters)`: Get channels from the API.
	+ `channelLocalDataSource.saveFavoriteStatus(channelId, isFavorite)`: Update local storage.

### ChannelRemoteDataSource

* **Description**: Handles network requests to fetch channel data.
* **Key Functions**:
	+ `fetchChannels(List<String> filters) -> Future<List<ChannelModel>>`
* **Expected Calls**:
	+ `apiClient.get('/channels', queryParams)`: Makes an HTTP request to fetch channels.

### ChannelModel

* **Description**: Data transfer object representing a channel. Used to convert JSON data to ChannelEntity.
* **Key Functions**:
	+ `fromJson(Map<String, dynamic> json) -> ChannelModel`
	+ `toEntity() -> ChannelEntity`
* **No expected calls** by itself, mainly used internally in data layer.

## Other Features (High-Level Classes)

### Channels Feature

#### ChannelsPage

* **UI**: Lists favorite channels.
* **Interacts with**: ChannelsViewModel to load favorite channels and navigate to FeedPage.

#### ChannelsViewModel

* **Handles logic**: For loading favorite channels.
* **Calls**: GetFavoriteChannels use case.

#### GetFavoriteChannels (Use Case)

* **Executes repository method**: To fetch stored favorite channels.

#### FavoriteChannelRepositoryImpl

* **Implements**: FavoriteChannelRepository, interacts with local data source to persist favorite channels.

### Feed Feature

#### FeedPage

* **Displays**: Messages in the selected channel and input field for sending text.
* **Back button**: Returns to ScanPage.

#### FeedViewModel

* **Loads and listens**: To messages in a channel, handles sending messages.
* **Calls**: GetMessages and SendMessage use cases.

#### GetMessages (Use Case)

* **Retrieves messages**: For a given channel from MessageRepository.

#### SendMessage (Use Case)

* **Posts a new text message**: Via MessageRepository.

#### MessageRepositoryImpl

* **Fetches and sends messages**: Using MessageRemoteDataSource.

### Filter Feature

#### FilterPage

* **A UI page**: Displaying segmented filters (whisper/broadcast, friends percentage, location, work).
* **Allows saving or resetting filters**.

#### FilterViewModel

* **Manages filter states**: Calls UpdateFilterSettings use case.

#### UpdateFilterSettings (Use Case)

* **Persists current filter settings**: Via FilterRepository.

#### FilterRepositoryImpl

* **Stores/retrieves filter settings**: From a local data source.

### Tokens & Connectivity Features

#### TokensPage and ConnectivityPage

* **Currently placeholders**: Will follow a similar pattern:
	+ ViewModel interacts with GetTokens or CheckConnectivity use cases.
	+ Repositories and data sources as needed for tokens or connectivity status.

## Class Relationships in YAML

Below is a simplified YAML representation describing relationships and dependencies between classes. Adjust or expand as needed:

```yml
presentation:
  ScanPage:
    depends_on:
      - ScanViewModel
    displays:
      - ChannelCard
    triggers:
      - loadChannels(filters)
      - toggleFavoriteChannel(channel)
  ScanViewModel:
    depends_on:
      - GetFilteredChannels (use case)
      - FavoriteChannel (use case)
    operations:
      - loadChannels -> GetFilteredChannels.execute(filters)
      - toggleFavoriteChannel -> FavoriteChannel.execute(channel, isFavorite)

domain:
  ChannelEntity:
    properties:
      - id: String
      - name: String
      - description: String
      - isFavorite: bool
  GetFilteredChannels:
    depends_on:
      - ChannelRepository
    operations:
      - execute(filters) -> List<ChannelEntity>
  FavoriteChannel:
    depends_on:
      - ChannelRepository
    operations:
      - execute(channel, isFavorite) -> void

data:
  ChannelRepositoryImpl:
    implements:
      - ChannelRepository
    depends_on:
      - ChannelRemoteDataSource
      - ChannelLocalDataSource (optional)
    operations:
      - getChannelsFiltered(filters) -> List<ChannelEntity>
      - updateFavoriteStatus(channelId, isFavorite) -> void
  ChannelRemoteDataSource:
    operations:
      - fetchChannels(filters) -> List<ChannelModel>
  ChannelModel:
    operations:
      - toEntity() -> ChannelEntity
    used_by:
      - ChannelRemoteDataSource (to map JSON to entities)

common:
  AppRouter:
    used_by:
      - All presentation pages for navigation
  CustomBottomNavBar:
    used_by:
      - ScanPage
      - ChannelsPage
      - TokensPage
      - ConnectivityPage
    operations:
      - navigateToScan()
      - navigateToChannels()
      - navigateToFeed()
      - navigateToTokens()
      - navigateToConnectivity()
```

## Summary

The above descriptions and YAML mapping provide a clearer understanding of the classes, their responsibilities, and how they interact with each other. This approach ensures a modular, testable, and maintainable codebase for your Dart/Flutter application.
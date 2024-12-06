import '../entities/channel_entity.dart';

abstract class ChannelRepository {
  Future<List<ChannelEntity>> getChannelsFiltered(List<String> filters);
  Future<void> updateFavoriteStatus(String channelId, bool isFavorite);
  Future<List<ChannelEntity>> getFavoriteChannels();
  Future<ChannelEntity?> getChannelById(String id);
}

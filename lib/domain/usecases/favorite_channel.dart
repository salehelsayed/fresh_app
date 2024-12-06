import '../repositories/channel_repository.dart';

class FavoriteChannel {
  final ChannelRepository repository;

  FavoriteChannel(this.repository);

  Future<void> execute(String channelId, bool isFavorite) {
    return repository.updateFavoriteStatus(channelId, isFavorite);
  }
}

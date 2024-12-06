import '../entities/channel_entity.dart';
import '../repositories/channel_repository.dart';

class GetFilteredChannels {
  final ChannelRepository repository;

  GetFilteredChannels(this.repository);

  Future<List<ChannelEntity>> execute(List<String> filters) {
    return repository.getChannelsFiltered(filters);
  }
}

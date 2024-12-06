import '../../domain/entities/channel_entity.dart';

class ChannelModel extends ChannelEntity {
  const ChannelModel({
    required String id,
    required String name,
    required String description,
    required int activeUsers,
    required bool isFavorite,
    required String category,
    required DateTime createdAt,
  }) : super(
          id: id,
          name: name,
          description: description,
          activeUsers: activeUsers,
          isFavorite: isFavorite,
          category: category,
          createdAt: createdAt,
        );

  factory ChannelModel.fromJson(Map<String, dynamic> json) {
    return ChannelModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      activeUsers: json['activeUsers'] as int,
      isFavorite: json['isFavorite'] as bool,
      category: json['category'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'activeUsers': activeUsers,
      'isFavorite': isFavorite,
      'category': category,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ChannelModel.fromEntity(ChannelEntity entity) {
    return ChannelModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      activeUsers: entity.activeUsers,
      isFavorite: entity.isFavorite,
      category: entity.category,
      createdAt: entity.createdAt,
    );
  }
}

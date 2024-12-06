import 'package:equatable/equatable.dart';

class ChannelEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final int activeUsers;
  final bool isFavorite;
  final String category;
  final DateTime createdAt;

  const ChannelEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.activeUsers,
    required this.isFavorite,
    required this.category,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        activeUsers,
        isFavorite,
        category,
        createdAt,
      ];
}

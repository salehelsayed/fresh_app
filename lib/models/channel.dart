import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Channel extends Equatable {
  final String id;
  final String name;
  final String description;
  final int activeUsers;
  final bool isFavorite;
  final String category; // 'friends', 'map', 'work', 'hashtags'
  final DateTime createdAt;

  Channel({
    String? id,
    required this.name,
    required this.description,
    this.activeUsers = 0,
    this.isFavorite = false,
    required this.category,
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Channel copyWith({
    String? name,
    String? description,
    int? activeUsers,
    bool? isFavorite,
    String? category,
  }) {
    return Channel(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      activeUsers: activeUsers ?? this.activeUsers,
      isFavorite: isFavorite ?? this.isFavorite,
      category: category ?? this.category,
      createdAt: createdAt,
    );
  }

  @override
  List<Object?> get props => [id, name, description, activeUsers, isFavorite, category, createdAt];
}

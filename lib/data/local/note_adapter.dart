import 'package:hive/hive.dart';

import '../../domain/entities/note.dart';

part 'note_adapter.g.dart';

@HiveType(typeId: 0)
class NoteHive {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String content;

  @HiveField(3)
  final DateTime createdAt;

  @HiveField(4)
  final DateTime updatedAt;

  @HiveField(5)
  final String color;

  @HiveField(6)
  final bool isSynced;

  NoteHive({
    this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.color,
    required this.isSynced,
  });

  // Add copyWith method
  NoteHive copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? color,
    bool? isSynced,
  }) {
    return NoteHive(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      color: color ?? this.color,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  factory NoteHive.fromEntity(Note note) {
    return NoteHive(
      id: note.id,
      title: note.title,
      content: note.content,
      createdAt: note.createdAt,
      updatedAt: note.updatedAt,
      color: note.color,
      isSynced: note.isSynced,
    );
  }

  Note toEntity() {
    return Note(
      id: id,
      title: title,
      content: content,
      createdAt: createdAt,
      updatedAt: updatedAt,
      color: color,
      isSynced: isSynced,
    );
  }
}

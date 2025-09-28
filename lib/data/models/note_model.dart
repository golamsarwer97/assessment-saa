import 'package:equatable/equatable.dart';
import '../../domain/entities/note.dart';

class NoteModel extends Equatable {
  final String? id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String color;
  final bool isSynced;

  const NoteModel({
    this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.color,
    required this.isSynced,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id']?.toString(),
      title: json['title'],
      content: json['content'] ?? json['body'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toString()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toString()),
      color: json['color'] ?? '#2196F3',
      isSynced: json['isSynced'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'color': color,
      'isSynced': isSynced,
    };
  }

  Map<String, dynamic> toApiJson() {
    return {
      'title': title,
      'body': content,
      'userId': 1, // Mock user ID
    };
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

  @override
  List<Object?> get props {
    return [id, title, content, createdAt, updatedAt, color, isSynced];
  }
}

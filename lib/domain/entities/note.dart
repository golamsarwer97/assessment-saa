import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String? id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String color;
  final bool isSynced;

  const Note({
    this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.color,
    required this.isSynced,
  });

  Note copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? color,
    bool? isSynced,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      color: color ?? this.color,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  @override
  List<Object?> get props {
    return [id, title, content, createdAt, updatedAt, color, isSynced];
  }
}

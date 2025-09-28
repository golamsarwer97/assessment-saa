import 'package:hive/hive.dart';

import '../../core/constants/app_constants.dart';
import '../../core/errors/exceptions.dart';
import '../local/note_adapter.dart';

abstract class NoteLocalDataSource {
  Future<List<NoteHive>> getNotes();
  Future<void> saveNote(NoteHive note);
  Future<void> deleteNote(String id);
  Future<void> clearNotes();
}

class NoteLocalDataSourceImpl implements NoteLocalDataSource {
  @override
  Future<List<NoteHive>> getNotes() async {
    try {
      final box = await Hive.openBox<NoteHive>(AppConstants.notesBox);
      return box.values.toList();
    } catch (e) {
      throw CacheException('Failed to get notes from local storage: $e');
    }
  }

  @override
  Future<void> saveNote(NoteHive note) async {
    try {
      final box = await Hive.openBox<NoteHive>(AppConstants.notesBox);
      await box.put(note.id ?? DateTime.now().millisecondsSinceEpoch.toString(), note);
    } catch (e) {
      throw CacheException('Failed to save note to local storage: $e');
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    try {
      final box = await Hive.openBox<NoteHive>(AppConstants.notesBox);
      await box.delete(id);
    } catch (e) {
      throw CacheException('Failed to delete note from local storage: $e');
    }
  }

  @override
  Future<void> clearNotes() async {
    try {
      final box = await Hive.openBox<NoteHive>(AppConstants.notesBox);
      await box.clear();
    } catch (e) {
      throw CacheException('Failed to clear notes from local storage: $e');
    }
  }
}

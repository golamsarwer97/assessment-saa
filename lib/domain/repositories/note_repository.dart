import 'package:dartz/dartz.dart';
import '../entities/note.dart';
import '../../core/errors/failures.dart';

abstract class NoteRepository {
  Future<Either<Failure, List<Note>>> getNotes();
  Future<Either<Failure, Note>> saveNote(Note note);
  Future<Either<Failure, void>> deleteNote(String id);
  Future<Either<Failure, void>> syncNotes();
}

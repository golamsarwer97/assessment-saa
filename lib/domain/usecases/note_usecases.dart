import 'package:dartz/dartz.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';
import '../../core/errors/failures.dart';

class GetNotesUseCase {
  final NoteRepository repository;

  GetNotesUseCase(this.repository);

  Future<Either<Failure, List<Note>>> execute() async {
    return await repository.getNotes();
  }
}

class SaveNoteUseCase {
  final NoteRepository repository;

  SaveNoteUseCase(this.repository);

  Future<Either<Failure, Note>> execute(Note note) async {
    return await repository.saveNote(note);
  }
}

class DeleteNoteUseCase {
  final NoteRepository repository;

  DeleteNoteUseCase(this.repository);

  Future<Either<Failure, void>> execute(String id) async {
    return await repository.deleteNote(id);
  }
}

class SyncNotesUseCase {
  final NoteRepository repository;

  SyncNotesUseCase(this.repository);

  Future<Either<Failure, void>> execute() async {
    return await repository.syncNotes();
  }
}

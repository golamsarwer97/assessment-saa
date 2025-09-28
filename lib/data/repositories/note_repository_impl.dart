import 'package:dartz/dartz.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';
import '../datasources/note_local_data_source.dart';
import '../datasources/note_remote_data_source.dart';
import '../local/note_adapter.dart';
import '../models/note_model.dart';
import '../../core/errors/failures.dart';
import '../../core/errors/exceptions.dart';
import '../../core/network/network_info.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteLocalDataSource localDataSource;
  final NoteRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  NoteRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Note>>> getNotes() async {
    try {
      final noteHives = await localDataSource.getNotes();
      final notes = noteHives.map((hive) => hive.toEntity()).toList();
      return Right(notes);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, Note>> saveNote(Note note) async {
    try {
      final noteHive = NoteHive.fromEntity(note);
      await localDataSource.saveNote(noteHive);

      // Try to sync if online
      if (await networkInfo.isConnected) {
        try {
          final noteModel = NoteModel(
            id: note.id,
            title: note.title,
            content: note.content,
            createdAt: note.createdAt,
            updatedAt: note.updatedAt,
            color: note.color,
            isSynced: true,
          );
          await remoteDataSource.syncNote(noteModel);

          // Update local note as synced using copyWith
          final syncedNoteHive = noteHive.copyWith(isSynced: true);
          await localDataSource.saveNote(syncedNoteHive);

          return Right(syncedNoteHive.toEntity());
        } catch (e) {
          // If sync fails, keep note as unsynced
          final unsyncedNoteHive = noteHive.copyWith(isSynced: false);
          await localDataSource.saveNote(unsyncedNoteHive);
          return Right(unsyncedNoteHive.toEntity());
        }
      } else {
        // If offline, mark as unsynced
        final unsyncedNoteHive = noteHive.copyWith(isSynced: false);
        await localDataSource.saveNote(unsyncedNoteHive);
        return Right(unsyncedNoteHive.toEntity());
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNote(String id) async {
    try {
      await localDataSource.deleteNote(id);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> syncNotes() async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(NetworkFailure('No internet connection'));
      }

      final notes = await localDataSource.getNotes();
      final unsyncedNotes = notes.where((note) => !note.isSynced);

      for (final note in unsyncedNotes) {
        try {
          final noteModel = NoteModel(
            id: note.id,
            title: note.title,
            content: note.content,
            createdAt: note.createdAt,
            updatedAt: note.updatedAt,
            color: note.color,
            isSynced: true,
          );
          await remoteDataSource.syncNote(noteModel);

          // Convert to entity, use copyWith, then convert back
          final noteEntity = note.toEntity();
          final syncedEntity = noteEntity.copyWith(isSynced: true);
          final syncedNote = NoteHive.fromEntity(syncedEntity);

          await localDataSource.saveNote(syncedNote);
        } catch (e) {
          // Continue with other notes even if one fails
          continue;
        }
      }

      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error: $e'));
    }
  }
}

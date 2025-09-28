import 'package:get/get.dart';
import '../../domain/entities/note.dart';
import '../../domain/usecases/note_usecases.dart';
import '../../core/errors/failures.dart';

class NoteController extends GetxController {
  final GetNotesUseCase getNotesUseCase;
  final SaveNoteUseCase saveNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final SyncNotesUseCase syncNotesUseCase;

  final notes = <Note>[].obs;
  final filteredNotes = <Note>[].obs;
  final isLoading = false.obs;
  final searchQuery = ''.obs;

  NoteController({
    required this.getNotesUseCase,
    required this.saveNoteUseCase,
    required this.deleteNoteUseCase,
    required this.syncNotesUseCase,
  });

  @override
  void onInit() {
    loadNotes();
    super.onInit();
  }

  Future<void> loadNotes() async {
    isLoading.value = true;
    final result = await getNotesUseCase.execute();
    result.fold(
      (failure) => Get.snackbar('Error', failure.message),
      (notesList) {
        notes.value = notesList;
        filterNotes();
      },
    );
    isLoading.value = false;
  }

  Future<void> saveNote(Note note) async {
    final result = await saveNoteUseCase.execute(note);
    result.fold(
      (failure) => {Get.snackbar('Error', failure.message), print(failure.message)},
      (savedNote) {
        final index = notes.indexWhere((n) => n.id == note.id);
        if (index != -1) {
          notes[index] = savedNote;
        } else {
          notes.add(savedNote);
        }
        filterNotes();
        Get.snackbar('Success', 'Note saved successfully');
      },
    );
  }

  Future<void> deleteNote(String id) async {
    final result = await deleteNoteUseCase.execute(id);
    result.fold(
      (failure) => Get.snackbar('Error', failure.message),
      (_) {
        notes.removeWhere((note) => note.id == id);
        filterNotes();
        Get.snackbar('Success', 'Note deleted successfully');
      },
    );
  }

  Future<void> syncNotes() async {
    final result = await syncNotesUseCase.execute();
    result.fold(
      (failure) => Get.snackbar('Error', failure.message),
      (_) {
        loadNotes(); // Reload to get updated sync status
        Get.snackbar('Success', 'Notes synced successfully');
      },
    );
  }

  void filterNotes([String query = '']) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredNotes.value = notes;
    } else {
      filteredNotes.value = notes.where((note) => note.title.toLowerCase().contains(query.toLowerCase()) || note.content.toLowerCase().contains(query.toLowerCase())).toList();
    }
  }
}

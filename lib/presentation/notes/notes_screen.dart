import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../domain/entities/note.dart';
import 'note_controller.dart';
import '../widgets/note_card.dart';

class NotesScreen extends GetView<NoteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: [
          IconButton(
            icon: Icon(Icons.sync),
            onPressed: controller.syncNotes,
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showNoteDialog(),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(2.w),
        child: Column(
          children: [
            TextField(
              onChanged: controller.filterNotes,
              decoration: InputDecoration(
                hintText: 'Search notes...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 2.h),
            Obx(() => Expanded(
                  child: ListView.builder(
                    itemCount: controller.filteredNotes.length,
                    itemBuilder: (context, index) {
                      final note = controller.filteredNotes[index];
                      return NoteCard(
                        note: note,
                        onTap: () => _showNoteDialog(note: note),
                        onDelete: () => controller.deleteNote(note.id!),
                      );
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void _showNoteDialog({Note? note}) {
    final titleController = TextEditingController(text: note?.title ?? '');
    final contentController = TextEditingController(text: note?.content ?? '');
    String selectedColor = note?.color ?? '#2196F3';

    Get.dialog(
      AlertDialog(
        title: Text(note == null ? 'Create Note' : 'Edit Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 2.h),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: 'Content'),
              maxLines: 3,
            ),
            SizedBox(height: 2.h),
            DropdownButton<String>(
              value: selectedColor,
              items: [
                DropdownMenuItem(value: '#2196F3', child: Text('Blue')),
                DropdownMenuItem(value: '#4CAF50', child: Text('Green')),
                DropdownMenuItem(value: '#FF9800', child: Text('Orange')),
                DropdownMenuItem(value: '#F44336', child: Text('Red')),
                DropdownMenuItem(value: '#9C27B0', child: Text('Purple')),
              ],
              onChanged: (value) {
                selectedColor = value!;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newNote = Note(
                id: note?.id,
                title: titleController.text,
                content: contentController.text,
                createdAt: note?.createdAt ?? DateTime.now(),
                updatedAt: DateTime.now(),
                color: selectedColor,
                isSynced: note?.isSynced ?? false,
              );
              controller.saveNote(newNote);
              Get.back();
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}

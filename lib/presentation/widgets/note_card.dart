import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../domain/entities/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const NoteCard({
    Key? key,
    required this.note,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _getColorFromString(note.color).withOpacity(0.1),
      child: ListTile(
        leading: Icon(
          Icons.note,
          color: _getColorFromString(note.color),
        ),
        title: Text(
          note.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4),
            Text(
              'Updated: ${_formatDate(note.updatedAt)}',
              style: TextStyle(fontSize: 10.sp, color: Colors.grey),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!note.isSynced) Icon(Icons.cloud_off, size: 16, color: Colors.orange),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  Color _getColorFromString(String colorString) {
    try {
      return Color(int.parse(colorString.replaceAll('#', '0xFF')));
    } catch (e) {
      return Colors.blue;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

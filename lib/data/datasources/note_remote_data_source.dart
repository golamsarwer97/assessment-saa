import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/app_constants.dart';
import '../../core/errors/exceptions.dart';
import '../models/note_model.dart';

abstract class NoteRemoteDataSource {
  Future<void> syncNote(NoteModel note);
}

class NoteRemoteDataSourceImpl implements NoteRemoteDataSource {
  final http.Client client;

  NoteRemoteDataSourceImpl(this.client);

  @override
  Future<void> syncNote(NoteModel note) async {
    final response = await client.post(
      Uri.parse('${AppConstants.jsonPlaceholderUrl}/posts'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(note.toApiJson()),
    );

    if (response.statusCode != 201) {
      throw ServerException('Failed to sync note: ${response.statusCode}');
    }
  }
}

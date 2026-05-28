import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:taskflow/api/api_exception.dart';
import 'package:taskflow/api/task_json_mapper.dart';
import 'package:taskflow/config/app_config.dart';
import 'package:taskflow/models/task.dart';
import 'package:taskflow/models/task_category.dart';
import 'package:taskflow/models/task_priority.dart';

class TaskApiClient {
  TaskApiClient({
    http.Client? httpClient,
    String? baseUrl,
    Duration? timeout,
  })  : _client = httpClient ?? http.Client(),
        _baseUrl = baseUrl ?? AppConfig.apiBaseUrl,
        _timeout = timeout ?? AppConfig.apiTimeout;

  final http.Client _client;
  final String _baseUrl;
  final Duration _timeout;

  Uri _uri(String path) => Uri.parse('$_baseUrl$path');

  Future<List<Task>> fetchAll() async {
    final response = await _client
        .get(
          _uri('/tasks'),
          headers: _headers,
        )
        .timeout(_timeout);
    return _decodeList(response);
  }

  Future<Task> create({
    required String title,
    String? description,
    required TaskCategory category,
    required TaskPriority priority,
    DateTime? deadline,
    String? photoPath,
  }) async {
    final body = TaskJsonMapper.toCreateJson(
      title: title,
      description: description,
      category: category,
      priority: priority,
      deadline: deadline,
      photoPath: photoPath,
    );
    final response = await _client
        .post(
          _uri('/tasks'),
          headers: _headers,
          body: jsonEncode(body),
        )
        .timeout(_timeout);
    return _decodeTask(response, expectedStatus: 201);
  }

  Future<Task> update(Task task) async {
    final response = await _client
        .put(
          _uri('/tasks/${task.id}'),
          headers: _headers,
          body: jsonEncode(TaskJsonMapper.toUpdateJson(task)),
        )
        .timeout(_timeout);
    return _decodeTask(response);
  }

  Future<void> delete(String id) async {
    final response = await _client
        .delete(
          _uri('/tasks/$id'),
          headers: _headers,
        )
        .timeout(_timeout);
    if (response.statusCode != 204 && response.statusCode != 200) {
      throw _errorFromResponse(response);
    }
  }

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  List<Task> _decodeList(http.Response response) {
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return TaskJsonMapper.listFromJson(decoded);
    }
    throw _errorFromResponse(response);
  }

  Task _decodeTask(http.Response response, {int expectedStatus = 200}) {
    final ok = response.statusCode == expectedStatus ||
        (expectedStatus == 201 && response.statusCode == 200);
    if (ok) {
      final decoded = jsonDecode(response.body) as Map<String, dynamic>;
      return TaskJsonMapper.fromJson(decoded);
    }
    throw _errorFromResponse(response);
  }

  ApiException _errorFromResponse(http.Response response) {
    String message = 'Erreur serveur (${response.statusCode})';
    try {
      final body = jsonDecode(response.body);
      if (body is Map<String, dynamic>) {
        message = (body['message'] ?? body['error'] ?? message).toString();
      }
    } catch (_) {}
    return ApiException(message, statusCode: response.statusCode);
  }

  void dispose() => _client.close();
}

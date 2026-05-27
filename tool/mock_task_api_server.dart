import 'dart:convert';
import 'dart:io';

void main() async {
  final tasks = <String, Map<String, dynamic>>{};
  var nextId = 1;

  final server = await HttpServer.bind(InternetAddress.anyIPv4, 8000);
  stdout.writeln('TaskFlow mock API → http://localhost:8000/api/tasks');

  await for (final request in server) {
    _addCors(request.response);

    if (request.method == 'OPTIONS') {
      request.response.statusCode = HttpStatus.noContent;
      await request.response.close();
      continue;
    }

    final path = request.uri.path;
    final segments = path.split('/').where((s) => s.isNotEmpty).toList();

    try {
      if (segments.length == 2 &&
          segments[0] == 'api' &&
          segments[1] == 'tasks') {
        switch (request.method) {
          case 'GET':
            _json(request.response, tasks.values.toList());
          case 'POST':
            final body = await _readJson(request);
            final id = (nextId++).toString();
            final task = {...body, 'id': id};
            tasks[id] = task;
            request.response.statusCode = HttpStatus.created;
            _json(request.response, task);
          default:
            _methodNotAllowed(request.response);
        }
      } else if (segments.length == 3 &&
          segments[0] == 'api' &&
          segments[1] == 'tasks') {
        final id = segments[2];
        switch (request.method) {
          case 'PUT':
            if (!tasks.containsKey(id)) {
              _notFound(request.response);
              break;
            }
            final body = await _readJson(request);
            final updated = {...body, 'id': id};
            tasks[id] = updated;
            _json(request.response, updated);
          case 'DELETE':
            if (tasks.remove(id) == null) {
              _notFound(request.response);
            } else {
              request.response.statusCode = HttpStatus.noContent;
              await request.response.close();
            }
          default:
            _methodNotAllowed(request.response);
        }
      } else {
        _notFound(request.response);
      }
    } catch (e) {
      request.response.statusCode = HttpStatus.badRequest;
      _json(request.response, {'message': e.toString()});
    }
  }
}

void _addCors(HttpResponse response) {
  response.headers
    ..add('Access-Control-Allow-Origin', '*')
    ..add('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS')
    ..add('Access-Control-Allow-Headers', 'Content-Type, Accept');
}

Future<Map<String, dynamic>> _readJson(HttpRequest request) async {
  final content = await utf8.decoder.bind(request).join();
  return jsonDecode(content) as Map<String, dynamic>;
}

void _json(HttpResponse response, Object data) {
  response.headers.contentType = ContentType.json;
  response.write(jsonEncode(data));
  response.close();
}

void _notFound(HttpResponse response) {
  response.statusCode = HttpStatus.notFound;
  _json(response, {'message': 'Ressource introuvable'});
}

void _methodNotAllowed(HttpResponse response) {
  response.statusCode = HttpStatus.methodNotAllowed;
  _json(response, {'message': 'Méthode non autorisée'});
}

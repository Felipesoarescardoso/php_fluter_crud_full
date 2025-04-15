import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = 'http://10.0.2.2/backend-php/api';

class ApiService {
  Future<List<Map<String, dynamic>>> fetchUsuarios() async {
    final res = await http.get(Uri.parse('$baseUrl/read.php'));
    final data = jsonDecode(res.body);
    return List<Map<String, dynamic>>.from(data['usuarios']);
  }

  Future<bool> createUsuario(String nome, String email, String senha) async {
    final res = await http.post(
      Uri.parse('$baseUrl/create.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'nome': nome, 'email': email, 'senha': senha}),
    );
    return jsonDecode(res.body)['status'] == 'success';
  }

  Future<bool> updateUsuario(int id, String nome, String email) async {
    final res = await http.post(
      Uri.parse('$baseUrl/update.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': id, 'nome': nome, 'email': email}),
    );
    return jsonDecode(res.body)['status'] == 'success';
  }

  Future<bool> deleteUsuario(int id) async {
    final res = await http.post(
      Uri.parse('$baseUrl/delete.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': id}),
    );
    return jsonDecode(res.body)['status'] == 'success';
  }
}

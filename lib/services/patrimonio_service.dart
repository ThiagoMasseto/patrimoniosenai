import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/patrimonio.dart';

class PatrimonioService {
  // Ajuste a URL conforme o ambiente:
  // - Emulador Android: http://10.0.2.2:8080
  // - Dispositivo físico: use o IP da máquina
  // - Web/Desktop: http://localhost:8080
  static const String baseUrl = 'http://localhost:8080/api/v1/patrimonios';

  /// GET /api/v1/patrimonios
  /// Response: { "success": true, "data": { "total": N, "patrimonios": [...] } }
  Future<List<Patrimonio>> getAll() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final List<dynamic> jsonList = body['data']['patrimonios'];
      return Patrimonio.fromJsonList(jsonList);
    } else {
      throw Exception('Erro ao carregar patrimônios: ${response.statusCode}');
    }
  }

  /// GET /api/v1/patrimonios?q=termo
  /// Response: { "success": true, "data": { "total": N, "patrimonios": [...] } }
  Future<List<Patrimonio>> search(String query) async {
    final uri = Uri.parse(baseUrl).replace(queryParameters: {'q': query});
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final List<dynamic> jsonList = body['data']['patrimonios'];
      return Patrimonio.fromJsonList(jsonList);
    } else {
      throw Exception('Erro ao pesquisar patrimônios: ${response.statusCode}');
    }
  }

  /// GET /api/v1/patrimonios/{id}
  /// Response: { "success": true, "data": { ... } }
  Future<Patrimonio> getById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      return Patrimonio.fromJson(body['data']);
    } else {
      throw Exception('Erro ao carregar patrimônio: ${response.statusCode}');
    }
  }

  /// POST /api/v1/patrimonios
  /// Response: { "success": true, "data": { ... } }
  Future<Patrimonio> create(Patrimonio patrimonio) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(patrimonio.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> body = json.decode(response.body);
      return Patrimonio.fromJson(body['data']);
    } else {
      throw Exception('Erro ao cadastrar patrimônio: ${response.statusCode}');
    }
  }

  /// PUT /api/v1/patrimonios/{id}
  /// Response: { "success": true, "data": { ... } }
  Future<Patrimonio> update(int id, Patrimonio patrimonio) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(patrimonio.toJson()),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      return Patrimonio.fromJson(body['data']);
    } else {
      throw Exception('Erro ao atualizar patrimônio: ${response.statusCode}');
    }
  }

  /// DELETE /api/v1/patrimonios/{id}
  /// Response: { "success": true, "message": "..." }
  Future<void> delete(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Erro ao excluir patrimônio: ${response.statusCode}');
    }
  }
}

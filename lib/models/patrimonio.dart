class Patrimonio {
  final int? id;
  final String nDoInventario;
  final String descricao;
  final String local;
  final String responsavel;
  final String? dataDeRegistro;

  Patrimonio({
    this.id,
    required this.nDoInventario,
    required this.descricao,
    required this.local,
    required this.responsavel,
    this.dataDeRegistro,
  });

  factory Patrimonio.fromJson(Map<String, dynamic> json) {
    return Patrimonio(
      id: json['id'],
      nDoInventario: json['n_do_inventario'] ?? '',
      descricao: json['descricao'] ?? '',
      local: json['local'] ?? '',
      responsavel: json['responsavel'] ?? '',
      dataDeRegistro: json['data_de_registro'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'n_do_inventario': nDoInventario,
      'descricao': descricao,
      'local': local,
      'responsavel': responsavel,
    };
  }

  static List<Patrimonio> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Patrimonio.fromJson(json)).toList();
  }
}

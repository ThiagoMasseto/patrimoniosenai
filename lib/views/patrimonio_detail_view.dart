import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/patrimonio_controller.dart';
import '../models/patrimonio.dart';

class PatrimonioDetailView extends StatelessWidget {
  const PatrimonioDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PatrimonioController>();
    final int patrimonioId = Get.arguments as int;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Patrimônio'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Editar',
            onPressed: () async {
              final patrimonio = await controller.getPatrimonio(patrimonioId);
              if (patrimonio != null) {
                Get.toNamed('/formulario', arguments: patrimonio);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Excluir',
            onPressed: () => _confirmarExclusao(context, controller, patrimonioId),
          ),
        ],
      ),
      body: FutureBuilder<Patrimonio?>(
        future: controller.getPatrimonio(patrimonioId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data == null) {
            return const Center(
              child: Text('Patrimônio não encontrado.'),
            );
          }

          final patrimonio = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildInfoCard(
                  icon: Icons.tag,
                  label: 'ID',
                  value: '${patrimonio.id}',
                ),
                _buildInfoCard(
                  icon: Icons.numbers,
                  label: 'Número do Inventário',
                  value: patrimonio.nDoInventario,
                ),
                _buildInfoCard(
                  icon: Icons.description,
                  label: 'Descrição',
                  value: patrimonio.descricao,
                ),
                _buildInfoCard(
                  icon: Icons.location_on,
                  label: 'Local',
                  value: patrimonio.local,
                ),
                _buildInfoCard(
                  icon: Icons.person,
                  label: 'Responsável',
                  value: patrimonio.responsavel,
                ),
                if (patrimonio.dataDeRegistro != null)
                  _buildInfoCard(
                    icon: Icons.calendar_today,
                    label: 'Data de Registro',
                    value: patrimonio.dataDeRegistro!,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFE30613)),
        title: Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _confirmarExclusao(
    BuildContext context,
    PatrimonioController controller,
    int id,
  ) {
    Get.defaultDialog(
      title: 'Confirmar Exclusão',
      middleText: 'Tem certeza que deseja excluir este patrimônio?',
      textCancel: 'Cancelar',
      textConfirm: 'Excluir',
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () async {
        Get.back(); // Fecha o diálogo
        final success = await controller.deletePatrimonio(id);
        if (success) {
          Get.back(); // Volta para a lista
        }
      },
    );
  }
}

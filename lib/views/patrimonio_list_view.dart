import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/patrimonio_controller.dart';

class PatrimonioListView extends StatelessWidget {
  const PatrimonioListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PatrimonioController>();
    final searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patrimônios'),
      ),
      body: Column(
        children: [
          // Campo de pesquisa
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Pesquisar patrimônios...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                    controller.searchPatrimonios('');
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (value) {
                controller.searchPatrimonios(value);
              },
            ),
          ),

          // Lista de patrimônios
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.patrimonios.isEmpty) {
                return const Center(
                  child: Text(
                    'Nenhum patrimônio encontrado.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: controller.fetchPatrimonios,
                child: ListView.builder(
                  itemCount: controller.patrimonios.length,
                  itemBuilder: (context, index) {
                    final patrimonio = controller.patrimonios[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          child: const Icon(Icons.inventory_2),
                        ),
                        title: Text(
                          patrimonio.descricao,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nº: ${patrimonio.nDoInventario}'),
                            Text('Local: ${patrimonio.local}'),
                            Text('Responsável: ${patrimonio.responsavel}'),
                          ],
                        ),
                        isThreeLine: true,
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Get.toNamed(
                            '/detalhes',
                            arguments: patrimonio.id,
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/formulario'),
        tooltip: 'Cadastrar patrimônio',
        child: const Icon(Icons.add),
      ),
    );
  }
}

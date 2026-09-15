import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/patrimonio_controller.dart';
import '../models/patrimonio.dart';

class PatrimonioFormView extends StatelessWidget {
  PatrimonioFormView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _numeroInventarioController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _localController = TextEditingController();
  final _responsavelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PatrimonioController>();

    // Verifica se é edição (patrimônio passado como argumento)
    final Patrimonio? patrimonioExistente =
        Get.arguments is Patrimonio ? Get.arguments as Patrimonio : null;
    final bool isEditing = patrimonioExistente != null;

    // Preenche os campos se for edição
    if (isEditing) {
      _numeroInventarioController.text = patrimonioExistente.nDoInventario;
      _descricaoController.text = patrimonioExistente.descricao;
      _localController.text = patrimonioExistente.local;
      _responsavelController.text = patrimonioExistente.responsavel;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Patrimônio' : 'Cadastrar Patrimônio'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _numeroInventarioController,
                decoration: const InputDecoration(
                  labelText: 'Número do Inventário',
                  prefixIcon: Icon(Icons.numbers),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o número do inventário';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe a descrição';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _localController,
                decoration: const InputDecoration(
                  labelText: 'Local',
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o local';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _responsavelController,
                decoration: const InputDecoration(
                  labelText: 'Responsável',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o responsável';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              ElevatedButton.icon(
                onPressed: () => _salvar(controller, isEditing, patrimonioExistente),
                icon: const Icon(Icons.save),
                label: Text(isEditing ? 'Atualizar' : 'Cadastrar'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _salvar(
    PatrimonioController controller,
    bool isEditing,
    Patrimonio? patrimonioExistente,
  ) async {
    if (!_formKey.currentState!.validate()) return;

    final patrimonio = Patrimonio(
      nDoInventario: _numeroInventarioController.text.trim(),
      descricao: _descricaoController.text.trim(),
      local: _localController.text.trim(),
      responsavel: _responsavelController.text.trim(),
    );

    bool success;
    if (isEditing) {
      success = await controller.updatePatrimonio(
        patrimonioExistente!.id!,
        patrimonio,
      );
    } else {
      success = await controller.createPatrimonio(patrimonio);
    }

    if (success) {
      Get.back();
    }
  }
}

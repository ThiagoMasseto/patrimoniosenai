import 'package:get/get.dart';
import '../models/patrimonio.dart';
import '../services/patrimonio_service.dart';

class PatrimonioController extends GetxController {
  final PatrimonioService _service = PatrimonioService();

  final patrimonios = <Patrimonio>[].obs;
  final isLoading = false.obs;
  final searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPatrimonios();
  }

  Future<void> fetchPatrimonios() async {
    try {
      isLoading.value = true;
      final result = await _service.getAll();
      patrimonios.assignAll(result);
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Não foi possível carregar os patrimônios.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchPatrimonios(String query) async {
    try {
      isLoading.value = true;
      searchQuery.value = query;
      final result =
          query.isEmpty ? await _service.getAll() : await _service.search(query);
      patrimonios.assignAll(result);
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Não foi possível pesquisar patrimônios.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<Patrimonio?> getPatrimonio(int id) async {
    try {
      return await _service.getById(id);
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Não foi possível carregar o patrimônio.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  Future<bool> createPatrimonio(Patrimonio patrimonio) async {
    try {
      await _service.create(patrimonio);
      await fetchPatrimonios();
      Get.snackbar(
        'Sucesso',
        'Patrimônio cadastrado com sucesso!',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Não foi possível cadastrar o patrimônio.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  Future<bool> updatePatrimonio(int id, Patrimonio patrimonio) async {
    try {
      await _service.update(id, patrimonio);
      await fetchPatrimonios();
      Get.snackbar(
        'Sucesso',
        'Patrimônio atualizado com sucesso!',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Não foi possível atualizar o patrimônio.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  Future<bool> deletePatrimonio(int id) async {
    try {
      await _service.delete(id);
      await fetchPatrimonios();
      Get.snackbar(
        'Sucesso',
        'Patrimônio excluído com sucesso!',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Não foi possível excluir o patrimônio.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }
}

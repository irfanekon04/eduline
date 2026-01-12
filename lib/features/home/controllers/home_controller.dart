import 'package:eduline/core/models/product_model.dart';
import 'package:eduline/core/services/api_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();

  var products = <ProductModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      isLoading.value = true;
      errorMessage.value = "";
      final result = await _apiService.fetchProducts();
      products.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}

import 'package:get/get.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/product_usecase.dart';

class ProductController extends GetxController {
  final GetProductsUseCase getProductsUseCase;

  final products = <Product>[].obs;
  final filteredProducts = <Product>[].obs;
  final isLoading = false.obs;
  final searchQuery = ''.obs;
  final selectedCategory = ''.obs;

  final categories = ["men's clothing", "women's clothing", "jewelery", "electronics"].obs;

  ProductController(this.getProductsUseCase);

  @override
  void onInit() {
    loadProducts();
    super.onInit();
  }

  Future<void> loadProducts() async {
    isLoading.value = true;
    final result = await getProductsUseCase.execute();
    result.fold(
      (failure) {
        Get.snackbar('Error', failure.message);
      },
      (productsList) {
        products.value = productsList;
        filterProducts();
      },
    );
    isLoading.value = false;
  }

  void searchProducts(String query) {
    searchQuery.value = query;
    filterProducts();
  }

  void filterByCategory(String? category) {
    selectedCategory.value = category ?? '';
    filterProducts();
  }

  void filterProducts() {
    var filtered = products.toList();

    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((product) => product.title.toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    // Apply category filter
    if (selectedCategory.isNotEmpty) {
      filtered = filtered.where((product) => product.category == selectedCategory.value).toList();
    }

    filteredProducts.value = filtered;
  }
}

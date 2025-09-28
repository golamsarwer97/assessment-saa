import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'product_controller.dart';
import '../widgets/product_card.dart';

class ProductsScreen extends GetView<ProductController> {
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.note),
            onPressed: () => Get.toNamed('/notes'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(2.w),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: controller.searchProducts,
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                SizedBox(width: 2.w),
                Obx(() => DropdownButton<String>(
                      value: controller.selectedCategory.value.isEmpty ? null : controller.selectedCategory.value,
                      hint: Text('Category'),
                      items: [
                        DropdownMenuItem(value: '', child: Text('All')),
                        ...controller.categories.map((category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                      ],
                      onChanged: controller.filterByCategory,
                    )),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return _buildSkeletonLoader();
              }

              return SmartRefresher(
                controller: _refreshController,
                onRefresh: () async {
                  await controller.loadProducts();
                  _refreshController.refreshCompleted();
                },
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2.w,
                    mainAxisSpacing: 2.w,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: controller.filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = controller.filteredProducts[index];
                    return ProductCard(product: product);
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonLoader() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 2.w,
        mainAxisSpacing: 2.w,
        childAspectRatio: 0.7,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
    );
  }
}

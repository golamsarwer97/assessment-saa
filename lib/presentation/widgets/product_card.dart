import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                image: DecorationImage(
                  image: NetworkImage(product.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  product.category,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

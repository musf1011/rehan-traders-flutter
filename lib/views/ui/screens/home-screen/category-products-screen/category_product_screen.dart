import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rehan_trader_website/core/services/product_service.dart';
import 'package:rehan_trader_website/models/product_model.dart';
import 'package:rehan_trader_website/view-models/controllers/screen_size_controller.dart';
import 'package:rehan_trader_website/views/widgets/home-screen-widgets/product_card.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String category;

  const CategoryProductsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = ResponsiveHelper.isMobile(context);
    return StreamBuilder<List<ProductModel>>(
      stream: ProductService().getProductsByCategory(category),

      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final products = snapshot.data!;

        return GridView.builder(
          padding: EdgeInsets.all(16.w),

          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isSmallScreen ? 2 : 3,
            childAspectRatio: isSmallScreen ? 0.8.h : 3.h,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),

          itemCount: products.length,

          itemBuilder: (_, index) {
            return ProductCard(product: products[index]);
          },
        );
      },
    );
  }
}

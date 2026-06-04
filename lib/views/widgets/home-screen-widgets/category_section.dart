import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rehan_trader_website/core/constants/app_constants.dart';
import 'package:rehan_trader_website/models/product_model.dart';
import 'package:rehan_trader_website/view-models/controllers/screen_size_controller.dart';
import 'package:rehan_trader_website/view-models/providers/main_provider.dart';
import 'package:rehan_trader_website/views/widgets/home-screen-widgets/product_card.dart';

class CategorySection extends StatelessWidget {
  final String category;
  final List<ProductModel> products;
  final int index;

  const CategorySection({
    super.key,
    required this.category,
    required this.products,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = ResponsiveHelper.isMobile(context);
    final mainProvider = context.watch<MainProvider>();
    // final index = category;
    return products.isEmpty
        ? SizedBox.shrink()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    category,
                    // style: TextStyle(
                    //   fontSize: 10.sp,
                    //   fontWeight: FontWeight.bold,
                    //   color: AppConstants.primaryColor,
                    // ),
                    style: TextStyle(
                      color: AppConstants.whiteColorP9, //was p5
                      fontWeight: FontWeight.bold,
                      fontSize: isSmallScreen ? 16.sp : 10.sp,
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => CategoryProductsScreen(category: category),
                      //   ),
                      // );
                      // NavigationService().navigateTo(
                      //   AppRoutes.categoryProducts,
                      //   arguments: category,
                      // );
                      mainProvider.onSidebarItemTapped(index + 1);
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(color: AppConstants.tertiaryColor),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: isSmallScreen ? 200.h : 450.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length > 5 ? 5 : products.length,
                  itemBuilder: (_, index) {
                    return ProductCard(product: products[index]);
                  },
                ),
              ),
            ],
          );
  }
}

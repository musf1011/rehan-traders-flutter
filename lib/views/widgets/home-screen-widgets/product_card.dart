import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rehan_trader_website/core/constants/app_constants.dart';
import 'package:rehan_trader_website/models/product_model.dart';
import 'package:rehan_trader_website/view-models/controllers/screen_size_controller.dart';
import 'package:rehan_trader_website/views/widgets/custom_image_view.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = ResponsiveHelper.isMobile(context);
    return Container(
      width: isSmallScreen ? 180.w : 100.w, //height control in category section
      margin: EdgeInsets.only(right: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),

      child: Column(
        mainAxisAlignment: .center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              child: CustomImageView(
                url: product.imageUrls.isNotEmpty
                    ? product.imageUrls.first
                    : 'assets/images/business-display-bg.png',
                width: double.infinity,
                fit: BoxFit.cover, //was fill
              ),
            ),
          ),

          Column(
            // crossAxisAlignment: .center,
            mainAxisAlignment: .center,
            children: [
              Text(
                product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: .center,
                style: TextStyle(
                  color: AppConstants.famzyGold,
                  fontWeight: .bold,
                ),
              ),

              SizedBox(height: 6.h),

              // Text(
              //   'Rs ${product.discountedPrice}',
              //   textAlign: .center,
              //   style: TextStyle(
              //     color: AppConstants.secondaryColor,
              //     fontWeight: .w500,
              //   ),
              // ),
              Row(
                mainAxisAlignment: .center,
                children: [
                  Text('Rs ${product.discountedPrice}'),

                  SizedBox(width: 8.w),

                  if (product.offerPercentage > 0)
                    Text(
                      'Rs ${product.originalPrice}',
                      style: TextStyle(decoration: TextDecoration.lineThrough),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

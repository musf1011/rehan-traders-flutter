import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rehan_trader_website/core/constants/app_constants.dart';
import 'package:rehan_trader_website/view-models/controllers/screen_size_controller.dart';
import 'package:rehan_trader_website/view-models/providers/product_provider.dart';
import 'package:rehan_trader_website/views/ui/resources/custom_loading_button.dart';
import 'package:rehan_trader_website/views/widgets/category_dropdown_form_field.dart';
import 'package:rehan_trader_website/views/widgets/custom_glass_wrapper.dart';
import 'package:rehan_trader_website/views/widgets/custom_text_form_field.dart';

class AdminProductForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  AdminProductForm({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final isSmallScreen = Provider.of<ScreenSizeController>(
      context,
    ).isSmallScreen;
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomGlassWrapper(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Product Images (Max 3 - Drag to reorder)",
                    textAlign: .center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 180.h, //was 120.h
                    child: ReorderableListView(
                      scrollDirection: Axis.horizontal,
                      onReorder: productProvider.reorderImages,
                      children: [
                        for (
                          int i = 0;
                          i < productProvider.selectedImages.length;
                          i++
                        )
                          Container(
                            key: ValueKey(productProvider.selectedImages[i]),
                            margin: EdgeInsets.only(right: 10.w),
                            width: 100.w,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: i == 0 ? Colors.green : Colors.grey,
                                width: 2,
                              ),
                              image: DecorationImage(
                                image: FileImage(
                                  productProvider.selectedImages[i],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: i == 0
                                ? Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      color: Colors.green,
                                      child: Text(
                                        "COVER",
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                        if (productProvider.selectedImages.length < 3)
                          GestureDetector(
                            key: ValueKey("add_btn"),
                            onTap: () {
                              /* Trigger Image Picker */
                            },
                            child: Container(
                              width: 100.w,
                              height: 200.h,
                              color: Colors.grey[200],
                              child: Icon(Icons.add_a_photo),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Pricing Section
                  Row(
                    children: [
                      Expanded(
                        // child: TextFormField(
                        //   decoration: InputDecoration(
                        //     labelText: "Price (RS)",
                        //     labelStyle: TextStyle(color: Colors.white),
                        //   ),
                        //   onChanged: (v) => pro.calculateDiscount(v, true),
                        // ),
                        child: CustomTextFormField(
                          label: 'Price',
                          hint: '100',
                          icon: Icons.money,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          suffixIcon: Text(
                            '\nPKR',
                            style: TextStyle(fontWeight: .bold),
                          ),
                          onChanged: (value) {
                            productProvider.calculateDiscount(value, true);
                          },
                          isSmallScreen: isSmallScreen,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        // child: TextFormField(
                        //   decoration: InputDecoration(labelText: "Offer %"),
                        //   onChanged: (v) =>
                        //       productProvider.calculateDiscount(v, false),
                        // ),
                        child: CustomTextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '*Price is required';
                            }
                            return null;
                          },
                          icon: Icons.local_offer,
                          label: 'Offer %',
                          hint: '0-100',
                          // suffixIcon: Text('\$'),
                          suffixIcon: Icon(
                            Icons.percent,
                            color: AppConstants.primaryTransGColor,
                          ),
                          isSmallScreen: isSmallScreen,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d{0,2}(\.\d{0,1})?$'),
                            ),
                          ],
                          onChanged: (value) {
                            // if (value.isEmpty) {
                            //   offerController.text = '0';
                            //   offerController.selection =
                            //       TextSelection.fromPosition(
                            //         TextPosition(
                            //           offset: offerController.text.length,
                            //         ),
                            //       );
                            // }

                            productProvider.calculateDiscount(value, false);
                          },

                          onTap: () {
                            // if (offerController.text == '0') {
                            //   offerController.selection = TextSelection(
                            //     baseOffset: 0,
                            //     extentOffset: offerController.text.length,
                            //   );
                            // }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Final Price: RS ${productProvider.finalPrice.toStringAsFixed(1)}",
                    style: TextStyle(
                      color: AppConstants.whiteColorP9,
                      fontWeight: FontWeight.bold,
                      fontSize: isSmallScreen ? 16.sp : 8.sp,
                    ),
                  ),

                  //   // Dropdown for Categories
                  //   DropdownButtonFormField(
                  //     items: categories
                  //         .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  //         .toList(),
                  //   onChanged: (v) {},
                  //   decoration: InputDecoration(labelText: "Category"),
                  // ),

                  //   SizedBox(height: 50.h),
                  CategoryDropdownFormField(
                    onChanged: (value) {
                      productProvider.category = value ?? '';
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Select a category';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            CustomLoadingButton(
              isSmallScreen: isSmallScreen,
              height: isSmallScreen ? 50.h : 80.h,
              width: isSmallScreen ? .7.sw : .4.sw,
              onPressed: () {
                /* Call Provider Save Method */
              },
              text: 'UPLOAD PRODUCT',
            ),
          ],
        ),
      ),
    );
  }
}

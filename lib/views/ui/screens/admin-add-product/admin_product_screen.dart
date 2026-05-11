//created by: FAMZY CodeWorks

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rehan_trader_website/core/constants/app_constants.dart';
import 'package:rehan_trader_website/core/services/navigation_service.dart';
import 'package:rehan_trader_website/view-models/controllers/screen_size_controller.dart';
import 'package:rehan_trader_website/view-models/providers/product_provider.dart';
import 'package:rehan_trader_website/views/ui/resources/custom_loading_button.dart';
import 'package:rehan_trader_website/views/widgets/category_dropdown_form_field.dart';
import 'package:rehan_trader_website/views/widgets/custom_glass_wrapper.dart';
import 'package:rehan_trader_website/views/widgets/custom_text_form_field.dart';

class AdminProductScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  AdminProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    // final isSmallScreen = Provider.of<ScreenSizeController>(
    //   context,
    // ).isSmallScreen;
    final isSmallScreen = ResponsiveHelper.isMobile(context);

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
                    height: isSmallScreen ? 110.h : 200.h, //was 120.h
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
                            key: ValueKey(
                              productProvider.selectedImages[i].name,
                            ),
                            margin: EdgeInsets.only(right: 10.w),
                            width: isSmallScreen ? 92.w : 65.w,
                            // height: isSmallScreen ? 100.h : 200.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: i == 0
                                    ? AppConstants.tertiaryColor
                                    : Colors.grey,
                                width: 2,
                              ),
                              image: DecorationImage(
                                // image: FileImage(
                                //   productProvider.selectedImages[i],
                                image: MemoryImage(
                                  productProvider.selectedImages[i].bytes,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            // child: i == 0
                            //     ? Align(
                            //         alignment: Alignment.bottomCenter,
                            //         child: Container(
                            //           color: Colors.green,
                            //           child: Text(
                            //             "COVER",
                            //             style: TextStyle(
                            //               fontSize: 10.sp,
                            //               color: Colors.white,
                            //             ),
                            //           ),
                            //         ),
                            //       )
                            //     : null,
                            child: Stack(
                              children: [
                                if (i == 0)
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      width: double.infinity,
                                      color: AppConstants.tertiaryColor,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 4.h,
                                      ),
                                      child: Text(
                                        "COVER",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 6.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),

                                Positioned(
                                  // top: isSmallScreen ? 5.h : 7.h,
                                  // right: isSmallScreen ? 5.w : 7.w,
                                  top: 5.h,
                                  right: 5.w,
                                  child: GestureDetector(
                                    onTap: () {
                                      productProvider.removeImage(i);
                                    },
                                    child: CircleAvatar(
                                      // minRadius: 18.h,
                                      radius: isSmallScreen ? 12.r : 24.r,
                                      backgroundColor: Colors.red,
                                      child: Icon(
                                        Icons.close,
                                        size: isSmallScreen ? 14.sp : 10.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        if (productProvider.selectedImages.length < 3)
                          GestureDetector(
                            key: ValueKey("add_btn"),
                            onTap: () async {
                              await productProvider.pickImages();
                            },
                            child: Container(
                              width: 100.w,
                              // height: 200.h,
                              color: AppConstants.whiteColorP7,
                              child: Center(child: Icon(Icons.add_a_photo)),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // noImageSelected
                  //     ? Text(
                  //         '*At least one image is required',
                  //         style: TextStyle(
                  //           color: Colors.red,
                  //           fontSize: isSmallScreen ? 10.sp : 4.sp,
                  //         ),
                  //       )
                  //     : SizedBox.shrink(),

                  // Image validation error message from provider
                  Selector<ProductProvider, String?>(
                    selector: (context, prod) => prod.imageValidationError,
                    builder: (context, imageValidationError, child) {
                      if (imageValidationError != null) {
                        debugPrint(
                          '*** product image valditor $imageValidationError',
                        );
                        return Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                            imageValidationError,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: isSmallScreen ? 10.sp : 4.sp,
                            ),
                          ),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),

                  CustomTextFormField(
                    controller: productProvider.nameController,
                    label: 'Product Name',
                    hint: 'Enter product name',
                    icon: Icons.shopping_bag,
                    isSmallScreen: isSmallScreen,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Product name required';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 15.h),

                  CustomTextFormField(
                    controller: productProvider.descriptionController,
                    label: 'Description',
                    hint: 'Enter product description',
                    icon: Icons.description,
                    maxLines: 3,
                    isSmallScreen: isSmallScreen,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Description required';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 20.h),

                  // Pricing Section
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller: productProvider.priceController,
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '*Price is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: CustomTextFormField(
                          controller: productProvider.offerController,

                          icon: Icons.local_offer,
                          label: 'Offer %',
                          hint: '0-100',
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
                            productProvider.calculateDiscount(value, false);
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

                  SizedBox(height: 50.h),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            CustomLoadingButton(
              isSmallScreen: isSmallScreen,
              isLoading: productProvider.isLoading,
              height: isSmallScreen ? 50.h : 80.h,
              width: isSmallScreen ? .7.sw : .4.sw,
              onPressed: () async {
                // Validate images using provider method
                productProvider.validateImages();
                if (_formKey.currentState?.validate() != true ||
                    !productProvider.validateImages()) {
                  debugPrint(
                    '****** image validattr : ${productProvider.validateImages()}',
                  );
                  return;
                }
                final bool result = await productProvider.uploadProduct();
                if (result) {
                  NavigationService().showSnackBar(
                    title: 'Success',
                    message: 'Product Added Successfully...',
                    type: ContentType.success,
                  );
                } else {
                  NavigationService().showSnackBar(
                    title: 'Failed',
                    message: 'Failed to add Product...',
                    type: ContentType.failure,
                  );
                }
              },
              text: 'UPLOAD PRODUCT',
            ),
          ],
        ),
      ),
    );
  }
}

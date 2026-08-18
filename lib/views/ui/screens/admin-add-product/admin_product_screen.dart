//created by: FAMZY CodeWorks

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rehan_trader_website/core/constants/app_constants.dart';
import 'package:rehan_trader_website/core/services/navigation_service.dart';
import 'package:rehan_trader_website/models/product_image_model.dart';
import 'package:rehan_trader_website/view-models/controllers/screen_size_controller.dart';
import 'package:rehan_trader_website/view-models/providers/product_provider.dart';
import 'package:rehan_trader_website/views/ui/resources/custom_loading_button.dart';
import 'package:rehan_trader_website/views/widgets/category_dropdown_form_field.dart';
import 'package:rehan_trader_website/views/widgets/custom_glass_wrapper.dart';
import 'package:rehan_trader_website/views/widgets/custom_text_form_field.dart';

// class AdminProductScreen extends StatelessWidget {
//   final _formKey = GlobalKey<FormState>();

//   AdminProductScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
class AdminProductScreen extends StatefulWidget {
  const AdminProductScreen({super.key});

  @override
  State<AdminProductScreen> createState() => _AdminProductScreenState();
}

class _AdminProductScreenState extends State<AdminProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final productProvider = context.read<ProductProvider>();
    final isSmallScreen = ResponsiveHelper.isMobile(context);

    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.all(16.w),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomGlassWrapper(
              child: Column(
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
                    child: Selector<ProductProvider, List<ProductImageModel>>(
                      shouldRebuild: (prev, next) => true,
                      selector: (_, prodProvider) =>
                          prodProvider.selectedImages,
                      builder: (_, selectedImages, _) => ReorderableListView(
                        scrollDirection: Axis.horizontal,
                        onReorder: productProvider.reorderImages,
                        children: [
                          for (int i = 0; i < selectedImages.length; i++)
                            Container(
                              key: ValueKey(selectedImages[i].name),
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
                                  image: MemoryImage(selectedImages[i].bytes),
                                  fit: BoxFit.cover,
                                ),
                              ),
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
                                          textAlign: .center,
                                          style: TextStyle(
                                            fontSize: 6.sp,
                                            color: Colors.black45,
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
                                        backgroundColor: AppConstants.lightRed,
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

                          if (selectedImages.length < 3)
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
                  ),

                  // Image validation error message from provider
                  Selector<ProductProvider, String?>(
                    selector: (_, prodProvider) =>
                        prodProvider.imageValidationError,
                    builder: (_, imageValidationError, _) {
                      if (productProvider.imageValidationError != null) {
                        debugPrint(
                          '*** product image valditor $imageValidationError',
                        );
                        return Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                            productProvider.imageValidationError ?? '',
                            style: TextStyle(
                              color: AppConstants.errorColor,
                              // backgroundColor: AppConstants.whiteColorP5,
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
                            color: AppConstants.primaryColor,
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
                  Selector<ProductProvider, double>(
                    selector: (_, prodProvider) => prodProvider.finalPrice,
                    builder: (_, finalPrice, child) => Text(
                      "Final Price: RS ${finalPrice.toStringAsFixed(0)}",
                      style: TextStyle(
                        color: AppConstants.whiteColorP9,
                        fontWeight: FontWeight.bold,
                        fontSize: isSmallScreen ? 16.sp : 8.sp,
                      ),
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
            Selector<ProductProvider, bool>(
              selector: (_, prodProvider) => prodProvider.isLoading,
              builder: (_, isLoading, __) => CustomLoadingButton(
                isSmallScreen: isSmallScreen,
                isLoading: isLoading,
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
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rehan_trader_website/presentation/constants/app_constants.dart';
import 'package:rehan_trader_website/presentation/providers/admin_auth_provider.dart';
import 'package:rehan_trader_website/presentation/providers/screen_size_controller.dart';
import 'package:rehan_trader_website/presentation/ui/resources/custom_loading_button.dart';
import 'package:rehan_trader_website/presentation/ui/widgets/custom_image_view.dart';
import 'package:rehan_trader_website/presentation/ui/widgets/custom_text_form_field.dart';
import 'package:rehan_trader_website/routes/app_routes.dart';
import 'package:rehan_trader_website/services/navigation_service.dart';

class AdminLoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final adminProvider = Provider.of<AdminProvider>(context);
    // Get the screen size controller
    final screenController = Provider.of<ScreenSizeController>(context);

    // Update screen size on each build (this will trigger rebuild when size changes)
    screenController.updateScreenSize(context);

    // Use the controller's isSmallScreen instead of calculating locally
    final isSmallScreen = screenController.isSmallScreen;

    return Scaffold(
      // backgroundColor: const Color(0xFFF5F7FA), // Light, clean grey
      body: Center(
        child: Container(
          width: isSmallScreen ? 0.85.sw : 0.5.sw,
          // height: 1.0.sh,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          // margin: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20.r,
                spreadRadius: 5.r,
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomImageView(
                  imagePath: AppConstants.companyLogo,
                  // margin: EdgeInsets.symmetric(vertical: 20.h),
                  // height: 120.h,
                  width: isSmallScreen ? 100.w : 50.w,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 10.h),
                Text(
                  "ADMIN LOGIN",
                  style: AppConstants.screenTitleTextStyle.copyWith(
                    fontSize: isSmallScreen ? 16.sp : 12.sp,
                  ),
                ),
                SizedBox(height: 10.h),

                // TextField(
                //   textAlign: .center,
                //   controller: emailController,
                //   style: TextStyle(fontSize: isSmallScreen ? 14.sp : 10.sp),
                //   decoration: InputDecoration(
                //     labelText: "Admin Email",

                //     labelStyle: TextStyle(fontSize: isSmallScreen ? 14.sp : 8.sp),
                //     prefixIcon: Icon(
                //       Icons.person,
                //       color: AppConstants.primaryTransGColor,
                //       size: isSmallScreen ? 20.sp : 12.sp,
                //     ),
                //   ),
                // ),
                CustomTextFormField(
                  label: "Admin Email",
                  hint: "Enter your email",
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  isSmallScreen: isSmallScreen,
                  icon: Icons.person,
                  inputFormatters: [],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                // TextField(
                //   controller: passController,
                //   obscureText: true,
                //   style: TextStyle(fontSize: isSmallScreen ? 14.sp : 10.sp),
                //   decoration: InputDecoration(
                //     labelText: "Password",
                //     labelStyle: TextStyle(
                //       fontSize: isSmallScreen ? 14.sp : 10.sp,
                //     ),
                //     prefixIcon: Icon(
                //       Icons.lock,
                //       color: AppConstants.primaryTransGColor,
                //       size: isSmallScreen ? 20.sp : 12.sp,
                //     ),
                //   ),
                // ),
                Consumer<AdminProvider>(
                  builder: (context, auth, chil) => CustomTextFormField(
                    label: "Password",
                    hint: "Enter your password",
                    controller: passController,
                    obscureText: true,
                    isSmallScreen: isSmallScreen,
                    isPasswordHidden: auth.isPasswordVisible,
                    toggleVisibility: auth.togglePasswordVisibility,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 40.h),

                CustomLoadingButton(
                  isSmallScreen: isSmallScreen,
                  width: isSmallScreen ? .3.sw : .2.sw,
                  onPressed: adminProvider.isLoading
                      ? () {}
                      : () async {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          bool ok = await adminProvider.attemptLogin(
                            emailController.text,
                            passController.text,
                            context,
                          );
                          if (ok) {
                            NavigationService().navigateAndClearStack(
                              AppRoutes.dashboard,
                            );
                          } else {
                            debugPrint("***Login failed****");
                          }
                        },
                  child: adminProvider.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: isSmallScreen ? 16.sp : 8.sp,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

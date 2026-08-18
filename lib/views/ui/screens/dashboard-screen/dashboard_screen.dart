//created by: FAMZY CodeWorks

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rehan_trader_website/core/constants/app_constants.dart';
import 'package:rehan_trader_website/view-models/providers/admin_auth_provider.dart';
import 'package:rehan_trader_website/view-models/providers/home_provider.dart';
import 'package:rehan_trader_website/view-models/providers/main_provider.dart';
import 'package:rehan_trader_website/view-models/controllers/screen_size_controller.dart';
import 'package:rehan_trader_website/views/ui/resources/custom_loading_button.dart';
import 'package:rehan_trader_website/views/ui/screens/admin-add-product/admin_product_screen.dart';
import 'package:rehan_trader_website/views/ui/screens/home-screen/category-products-screen/category_product_screen.dart';
import 'package:rehan_trader_website/views/ui/screens/home-screen/home_screen.dart';
import 'package:rehan_trader_website/views/widgets/custom_image_view.dart';
import 'package:rehan_trader_website/core/routes/app_routes.dart';
import 'package:rehan_trader_website/core/services/navigation_service.dart';
import 'package:sidebarx/sidebarx.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final mainProvider = context.watch<MainProvider>();
    final homeProvider = context.watch<HomeProvider>();
    final isSmallScreen = ResponsiveHelper.isMobile(context);
    final index = mainProvider.selectedIndex;
    return PopScope(
      canPop: isSmallScreen,

      child: Scaffold(
        backgroundColor: AppConstants.secondaryTransGColor,
        key: _key,
        // resizeToAvoidBottomInset: false,
        appBar: isSmallScreen
            ? AppBar(
                backgroundColor: AppConstants.primaryColor,
                // title: Text(mainProvider.currentTitle),
                title: Text(
                  index == 0
                      ? 'HOME'
                      : index == 100
                      ? 'ADD PRODUCT'
                      : homeProvider.categories[index - 1],
                ),
                titleTextStyle: AppConstants.appBarTextStyle,
                leading: IconButton(
                  onPressed: () {
                    _key.currentState?.openDrawer();
                  },
                  icon: const Icon(Icons.menu),
                ),
              )
            : null,
        drawer: isSmallScreen ? ExampleSidebarX() : null,
        body: Container(
          height: 1.sh,
          width: 1.sw,
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   colors: [AppConstants.transRColor, AppConstants.blackColorP3],
            // ),
            image: DecorationImage(
              image: AssetImage(AppConstants.appBgImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 1.0],
                colors: [AppConstants.transGrey, AppConstants.blackColorP7],
              ),
            ),
            child: Row(
              children: [
                if (!isSmallScreen) ExampleSidebarX(),
                Expanded(
                  child: Column(
                    children: [
                      _buildAttentionBanner(isSmallScreen),
                      Expanded(child: _ScreensExample()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAttentionBanner(bool isSmallScreen) {
    return Container(
      color: AppConstants.accentColor,
      width: 1.sw,
      height: .03.sh,
      child: Center(
        child: Text(
          'Attention! We deal in advance payment or physical pick up',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: isSmallScreen ? 10.sp : 5.sp,
          ),
        ),
      ),
    );
  }
}

class ExampleSidebarX extends StatelessWidget {
  const ExampleSidebarX({super.key});

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    final isAdminLoggedIn = context.select<AdminProvider, bool>(
      (adminProvider) => adminProvider.isAdminLoggedIn,
    );
    final homeProvider = Provider.of<HomeProvider>(context);

    final isSmallScreen = ResponsiveHelper.isMobile(context);

    return SidebarX(
      animationDuration: Duration(seconds: 2),

      controller: mainProvider.sideBarController,
      showToggleButton: false,
      theme: SidebarXTheme(
        // Used .r or fixed constraints for web stability
        width: isSmallScreen ? 70.r : 30.r,
        selectedTextStyle: TextStyle(
          // fontSize: isSmallScreen ? 16.sp : 8.sp,
          color: AppConstants.lightRed,
        ),

        // hoverColor: AppConstants.lightRed,//not wrking
        // itemPadding: EdgeInsets.only(left: 40.w),
        // selectedItemPadding: EdgeInsets.only(left: 400.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(20.r)),
          boxShadow: [
            BoxShadow(
              color: AppConstants.blackColorP7,
              offset: Offset(4.r, 10.r),
              blurRadius: 10.r,
              spreadRadius: 6.r,
            ),
          ],
        ),
      ),
      extendedTheme: SidebarXTheme(
        itemPadding: EdgeInsets.symmetric(vertical: 10.h),
        selectedItemPadding: EdgeInsets.only(left: 10.w),
        width: isSmallScreen ? 200.w : 80.w,
        decoration: BoxDecoration(
          color: AppConstants.whiteColorP9,
          borderRadius: BorderRadius.horizontal(right: Radius.circular(70.r)),
          boxShadow: [
            BoxShadow(
              color: Colors.black87,
              offset: Offset(0, 4.h),
              blurRadius: 1.r,
            ),
          ],
        ),
      ),
      headerBuilder: (context, extended) {
        return CustomImageView(
          imagePath: AppConstants.companyLogo,
          margin: EdgeInsets.symmetric(vertical: 20.h),
          // height: 120.h,
          width: isSmallScreen ? 100.w : 50.w,
          fit: BoxFit.contain,
        );
      },
      footerBuilder: (context, extended) {
        return
        // _buildFooter(context, isAdminLoggedIn);
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: isAdminLoggedIn
              ? CustomLoadingButton(
                  isSmallScreen: isSmallScreen,
                  width: isSmallScreen ? 140.w : 60.w,

                  onPressed: () async {
                    Provider.of<AdminProvider>(
                      context,
                      listen: false,
                    ).logout(context);
                  },
                  text: 'Log Out',
                )
              : Column(
                  children: [
                    Text(
                      'Are you Admin? To access more features',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 12.sp : 4.sp,
                        color: AppConstants.blackColorP7,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () {
                        NavigationService().navigateTo(
                          AppRoutes.adminLogin,
                        ); //neeed proper implementationfl
                      },
                      style: TextButton.styleFrom(),
                      child: Text('log in'),
                    ),
                  ],
                ),
        );
      },
      items: [
        _buildSidebarItem(context, 'HOME', 0),
        // ...homeProvider.categories.map((category) {
        //   return _buildSidebarItem(
        //     context,
        //     category.toUpperCase(),
        //     homeProvider.categories.indexOf(category),
        //   );
        // }),
        ...homeProvider.categories.asMap().entries.map((entry) {
          final index = entry.key;
          final category = entry.value;

          return _buildSidebarItem(context, category.toUpperCase(), index + 1);
        }),

        if (isAdminLoggedIn) _buildSidebarItem(context, 'ADD PRODUCT', 100),
        // _buildSidebarItem(context, 'SALES REGISTER', 2),
        // _buildSidebarItem(context, 'SALES REPORT', 2),
        // _buildSidebarItem(context, 'PRODUCTS', 3),
      ],
    );
  }

  SidebarXItem _buildSidebarItem(
    BuildContext context,
    String label,
    int index,
  ) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);

    final isSmallScreen = ResponsiveHelper.isMobile(context);
    return SidebarXItem(
      iconBuilder: (context, extended) => SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: isSmallScreen ? 16.sp : 8.sp,
                color: AppConstants.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            Visibility(
              // visible: mainProvider.selectedItems[index],
              visible: mainProvider.selectedIndex == index,
              child: Container(
                width: 30.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppConstants.primaryTransGColor,
                  borderRadius: BorderRadius.circular(5.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppConstants.blackColorP3,
                      offset: Offset(0, 4.h),
                      blurRadius: 4.r,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        mainProvider.onSidebarItemTapped(index);
        //close the drawer when an item is tapped (for small screens)
        if (isSmallScreen) {
          // Navigator.of(context).pop();
          NavigationService().pop();
        }
      },
    );
  }
}

class _ScreensExample extends StatelessWidget {
  const _ScreensExample();

  @override
  Widget build(BuildContext context) {
    final mainProvider = context.watch<MainProvider>();
    final homeProvider = context.watch<HomeProvider>();
    final index = mainProvider.selectedIndex;
    // final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: mainProvider.sideBarController,
      builder: (context, child) {
        // final pageTitle = mainProvider.currentTitle;
        // switch (mainProvider.sideBarController.selectedIndex) {
        //   case 0:
        //     return const HomeScreen();
        //   case 1:
        //     return CategoryProductsScreen(
        //       category: HomeProvider().categories[0],
        //     );

        //   // return const SalesRegisterScreen();
        //   case 2:
        //     return CategoryProductsScreen(
        //       category: HomeProvider().categories[1],
        //     );
        //   // return const SalesReportScreen();
        //   case 3:
        //     return CategoryProductsScreen(
        //       category: HomeProvider().categories[2],
        //     );
        //   // return AdminProductScreen();
        //   // return const ProductsScreen();
        //   case 4:
        //     return CategoryProductsScreen(
        //       category: HomeProvider().categories[3],
        //     );
        //   // return const PaymentsScreen();

        //   case 5:
        //     return CategoryProductsScreen(
        //       category: HomeProvider().categories[4],
        //     );
        //   case 6:
        //     return CategoryProductsScreen(
        //       category: HomeProvider().categories[5],
        //     );
        //   case 7:
        //     return CategoryProductsScreen(
        //       category: HomeProvider().categories[6],
        //     );
        //   case 8:
        //     return CategoryProductsScreen(
        //       category: HomeProvider().categories[7],
        //     );
        //   case 9:
        //     return AdminProductScreen();

        //   default:
        //     return Text(
        //       pageTitle,
        //       style: theme.textTheme.headlineSmall?.copyWith(fontSize: 24.sp),
        //     );
        // }
        // HOME
        if (index == 0) {
          return const HomeScreen();
        }
        // CATEGORIES
        if (index > 0 && index <= homeProvider.categories.length) {
          final category = homeProvider.categories[index - 1];

          return CategoryProductsScreen(category: category);
        }

        // ADMIN
        if (index == 100) {
          return AdminProductScreen();
        }

        return const SizedBox();
      },
    );
  }
}










    // Get the screen size controller
    // final screenController = Provider.of<ScreenSizeController>(context);

    // Update screen size on each build (this will trigger rebuild when size changes)
    // screenController.updateScreenSize(context);

    // Use the controller's isSmallScreen instead of calculating locally

    // final screenController = context.watch<ScreenSizeController>();

    // final isSmallScreen = screenController.isSmallScreen;

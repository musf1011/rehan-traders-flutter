//created by: FAMZY CodeWorks
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rehan_trader_website/core/constants/app_constants.dart';
import 'package:rehan_trader_website/view-models/providers/admin_auth_provider.dart';
import 'package:rehan_trader_website/view-models/providers/main_provider.dart';
import 'package:rehan_trader_website/view-models/controllers/screen_size_controller.dart';
import 'package:rehan_trader_website/views/ui/resources/custom_loading_button.dart';
import 'package:rehan_trader_website/views/ui/screens/admin-add-product/admin_product_screen.dart';
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
    final mainProvider = Provider.of<MainProvider>(context);
    // Get the screen size controller
    // final screenController = Provider.of<ScreenSizeController>(context);

    // Update screen size on each build (this will trigger rebuild when size changes)
    // screenController.updateScreenSize(context);

    // Use the controller's isSmallScreen instead of calculating locally

    // final screenController = context.watch<ScreenSizeController>();

    // final isSmallScreen = screenController.isSmallScreen;

    final isSmallScreen = ResponsiveHelper.isMobile(context);

    return Container(
      height: 1.sh,
      width: 1.sw,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppConstants.appBgImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: AppConstants.secondaryTransGColor,
        // drawerBarrierDismissible: true,
        // drawerDragStartBehavior: .down,
        drawerEdgeDragWidth: 120.w,

        // extendBody: true, //need to be studied more

        // extendBodyBehindAppBar: true,
        // onDrawerChanged: (mainProvider.onDrawerChanged),
        // primary: false,
        // resizeToAvoidBottomInset: false,
        key: _key,
        appBar: isSmallScreen
            ? AppBar(
                backgroundColor: AppConstants.primaryColor,
                title: Text(mainProvider.currentTitle),
                titleTextStyle: AppConstants.appBarTextStyle,
                leading: IconButton(
                  onPressed: () {
                    _key.currentState?.openDrawer();
                  },
                  icon: const Icon(Icons.menu),
                ),
              )
            : null,
        drawer: isSmallScreen
            ? ExampleSidebarX(
                // controller: _controller,
                // selectedItems: selectedItems,
                // onSidebarItemTapped: _onSidebarItemTapped,
                // isSmallScreen: isSmallScreen,
                // isAdminLoggedIn: isAdminLoggedIn,
              )
            : null,
        body: Row(
          children: [
            if (!isSmallScreen)
              ExampleSidebarX(
                // controller: _controller,
                // selectedItems: selectedItems,
                // onSidebarItemTapped: _onSidebarItemTapped,
                // isSmallScreen: isSmallScreen,
                // isAdminLoggedIn: isAdminLoggedIn,
              ),
            Expanded(
              child: Column(
                children: [
                  // Container(
                  //   color: AppConstants.accentColor,
                  //   width: 1.sw,
                  //   height: .03.sh,
                  //   child: Center(
                  //     child: Text(
                  //       'Attention! We deals in advance payment or physical pick up',
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.orange,
                  //         fontSize: isSmallScreen ? 14.sp : 5.sp,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  _buildAttentionBanner(isSmallScreen),
                  Expanded(
                    child: Container(
                      child: _ScreensExample(
                        controller: mainProvider.sideBarController,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
            color: Colors.orange,
            fontSize: isSmallScreen ? 14.sp : 5.sp,
          ),
        ),
      ),
    );
  }
}

class ExampleSidebarX extends StatelessWidget {
  const ExampleSidebarX({
    super.key,
    // required SidebarXController controller,
    // required this.selectedItems,
    // required this.onSidebarItemTapped,
    // required this.isSmallScreen,
    // required this.isAdminLoggedIn,
  })
  // : _controller = controller
  ;

  // final SidebarXController _controller;
  // final List<bool> selectedItems;
  // final ValueChanged<int> onSidebarItemTapped;
  // final bool isSmallScreen;
  // final bool isAdminLoggedIn;

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    final isAdminLoggedIn = context.select<AdminProvider, bool>(
      (adminProvider) => adminProvider.isAdminLoggedIn,
    );
    // final isSmallScreen = Provider.of<ScreenSizeController>(
    //   context,
    // ).isSmallScreen;

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
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(70.r), //was 30
          ),
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
                        NavigationService().navigateAndClearStack(
                          AppRoutes.adminLogin,
                        );
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
        if (isAdminLoggedIn) _buildSidebarItem(context, 'ADD PRODUCT', 1),
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
    // final isSmallScreen = Provider.of<ScreenSizeController>(
    //   context,
    // ).isSmallScreen;

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
              visible: mainProvider.selectedItems[index],
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
      // onTap: () => onSidebarItemTapped(index),
      onTap: () {
        mainProvider.onSidebarItemTapped(index);
        //close the drawer when an item is tapped (for small screens)
        if (isSmallScreen) {
          Navigator.of(context).pop();
        }
      },
    );
  }
}

class _ScreensExample extends StatelessWidget {
  const _ScreensExample({required this.controller});

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final pageTitle = _getTitleByIndex(controller.selectedIndex);
        switch (controller.selectedIndex) {
          case 0:
            return const HomeScreen();
          case 1:
            return AdminProductScreen();
          // return const SalesRegisterScreen();
          case 2:
          // return const SalesReportScreen();
          case 3:
          // return const ProductsScreen();
          case 4:
          // return const PaymentsScreen();

          case 5:
          default:
            return Text(
              pageTitle,
              style: theme.textTheme.headlineSmall?.copyWith(fontSize: 24.sp),
            );
        }
      },
    );
  }
}

String _getTitleByIndex(int index) {
  switch (index) {
    case 0:
      return 'HOME';
    case 1:
      return 'Sales Register';
    case 2:
      return 'Sales Report';
    case 3:
      return 'Products';
    case 4:
      return 'Payments';
    case 5:
      return 'ADD PRODUCT';
    default:
      return 'Not found page';
  }
}

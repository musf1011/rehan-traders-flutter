import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rehan_trader_website/firebase_options.dart';
import 'package:rehan_trader_website/core/constants/app_constants.dart';
import 'package:rehan_trader_website/view-models/providers/admin_auth_provider.dart';
import 'package:rehan_trader_website/view-models/providers/main_provider.dart';
import 'package:rehan_trader_website/view-models/controllers/screen_size_controller.dart';
import 'package:rehan_trader_website/core/routes/app_routes.dart';
import 'package:rehan_trader_website/core/routes/app_routes_observer.dart';
import 'package:rehan_trader_website/core/services/navigation_service.dart';
import 'package:provider/provider.dart';
import 'package:rehan_trader_website/view-models/providers/product_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Pre-initialize ScreenUtil for sizing logic
  await ScreenUtil.ensureScreenSize();
  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => ScreenSizeController()),
        ChangeNotifierProvider(create: (_) => AdminProvider()),
        ChangeNotifierProvider(create: (_) => MainProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: RehanTradersWeb(),
    ),
  );
}

class RehanTradersWeb extends StatelessWidget {
  const RehanTradersWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Rehan Traders',
          theme: ThemeData(
            scaffoldBackgroundColor: AppConstants.primaryTransGColor,
            useMaterial3: false,
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: AppConstants.tertiaryColor,
              selectionColor: AppConstants.primaryTransGColor,
              selectionHandleColor: AppConstants.tertiaryColor,
            ),
            radioTheme: RadioThemeData(
              fillColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppConstants.primaryColor;
                }
                return AppConstants.whiteColorP5;
              }),
            ),
          ),
          debugShowCheckedModeBanner: false,
          navigatorKey: NavigationService().navigatorKey,
          navigatorObservers: [AppRouteObserver()],
          initialRoute: AppRoutes.splash,
          onGenerateRoute: AppRoutes.generateRoute,
        );
      },
    );
  }
}

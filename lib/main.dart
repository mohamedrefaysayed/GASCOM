import 'package:dinar_store/core/data/services/firebase_services.dart';
import 'package:dinar_store/core/helpers/app_cache/cahch_helper.dart';
import 'package:dinar_store/core/helpers/notifications.dart';
import 'package:dinar_store/core/main_muli_bloc_provider.dart';
import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/app_routes.dart';
import 'package:dinar_store/core/utils/constants.dart';
import 'package:dinar_store/core/utils/genrall.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'dart:io';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();

  await FirebaseServices.init();

  Notifications.initilization(FlutterLocalNotificationsPlugin()); 

  isCustomer = CacheHelper.getData(key: "isCustomer") ?? true;
  userPhone = CacheHelper.getData(key: "userPhone") ?? "";
 HttpOverrides.global = MyHttpOverrides();
  runApp(
    const MyApp(),
  );
}

 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //check if device is mobile or tablet
    kIsTablet = MediaQuery.sizeOf(context).width >= 600;
    //set the status bar color to transparent
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: AppColors.kTransparent,
      ),
    );
    return MainMultiBlocProvider(
        child: ScreenUtilInit(
      designSize: const Size(375, 811),
      minTextAdapt: true,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Gaznaa',
          theme: ThemeData(
            fontFamily: 'SegoeUI',
            scaffoldBackgroundColor: Colors.white,
            colorScheme:
                ColorScheme.fromSeed(seedColor: AppColors.kASDCPrimaryColor),
            useMaterial3: true,
          ),
          initialRoute: '/',
          routes: AppRoutes.routes,
        ),
      ),
    ));
  }
}
